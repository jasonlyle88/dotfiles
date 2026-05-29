#shellcheck shell=bash

################################################################################
# Setup SSH helpers
################################################################################

############################################################
# Setup PKCS11 provider for hardware token support in agent
############################################################

if [[ -e '/opt/homebrew/lib/libykcs11.dylib' ]]; then
    # M-series yubico-piv-tool from brew PKCS11 provider
    export SSH_PKCS11_PROVIDER_LIBRARY='/opt/homebrew/lib/libykcs11.dylib'
elif [[ -e '/usr/local/lib/libykcs11.dylib' ]]; then
    # Intel yubico-piv-tool from brew PKCS11 provider
    # universal yubico-piv-tool from yubico package install PKCS11 provider
    export SSH_PKCS11_PROVIDER_LIBRARY='/usr/local/lib/libykcs11.dylib'
else
    printf -- 'Cannot find viable PKCS11 proivder library, not setting SSH_PKCS11_PROVIDER_LIBRARY variable\n' >&2
fi

if [[ -n "${SSH_PKCS11_PROVIDER_LIBRARY}" ]]; then
    export SSH_PKCS11_PROVIDER_LIBRARY="$(unlinkLib "${SSH_PKCS11_PROVIDER_LIBRARY}")"
fi


############################################################
##  SSH Helper functions
############################################################

export SSH_CONTROL_MASTER_DIRECTORY="${XDG_STATE_HOME}/ssh/cm"

ssh.aliases() {
    awk '
        tolower($1) == "host" {
            for (i = 2; i <= NF; i++) {
                if ($i == "#") break
                if ($i !~ /[*?]/) {
                    print $i
                }
            }
        }
    ' "${HOME}/.ssh/config" "${HOME}/.ssh/config.d"/* 2>/dev/null
}

ssh.controlPaths() {
    local sshAlias line hostname controlPath

    while IFS= read -r sshAlias; do
        hostname=""
        controlPath=""

        while IFS= read -r line; do
            case "${line}" in
                hostname\ *)    hostname="${line#hostname }" ;;
                controlpath\ *) controlPath="${line#controlpath }" ;;
            esac
        done < <(ssh -G "${sshAlias}" 2>/dev/null | grep -E '^(hostname|controlpath) ')

        if [[ -n "${controlPath}" ]]; then
            printf '%s\t%s\t%s\n' "${sshAlias}" "${hostname}" "${controlPath}"
        fi
    done < <(ssh.aliases)
}

ssh.connection.check() {
    local sshHostName="${1}"

    if ssh -O "check" "${sshHostName}" 1>/dev/null 2>&1; then
        printf -- "Connection is open\n"
        return 0
    else
        printf -- "Connection is not open\n"
        return 1
    fi
}

ssh.connection.kill() {
    local sshHostName="${1}"

    ssh -O "exit" "${sshHostName}"
}

ssh.connection.list() {
    local sshAlias hostname controlPath knownControlPath

    knownControlPath=""

    while IFS=$'\t' read -r sshAlias hostname controlPath; do
        knownControlPath="${knownControlPath}${controlPath}"$'\t'

        if ssh -O check "${sshAlias}" >/dev/null 2>&1; then
            printf '%-50s%s\n' "${sshAlias}" "${controlPath}"
        fi
    done < <(ssh.controlPaths)

    if [[ -d "${SSH_CONTROL_MASTER_DIRECTORY}" ]]; then
        while IFS= read -r controlPath; do
            if
                [[ "${knownControlPath}" != *"${controlPath}"$'\t'* ]] &&
                ssh -O check -S "${controlPath}" dummy >/dev/null 2>&1
            then
                printf '%-50s%s\n' 'Unknown' "${controlPath}"
            fi
        done < <(find "${SSH_CONTROL_MASTER_DIRECTORY}" -type s 2>/dev/null)
    fi
}


############################################################
##  Manage hardware token with SSH agent
############################################################
ssh.pkcs11.load() {
    ssh-add -s "${SSH_PKCS11_PROVIDER_LIBRARY}"
}

ssh.pkcs11.unload() {
    ssh-add -e "${SSH_PKCS11_PROVIDER_LIBRARY}"
}

ssh.pkcs11.reload() {
    ssh.pkcs11.unload 1>/dev/null 2>&1
    ssh.pkcs11.load
}

############################################################
##  Manage SSH tunnels
############################################################

ssh.tunnel.start() {
    local sshHostName="${1}"

    ssh -fN "${sshHostName}"
}

ssh.tunnel.check() {
    ssh.connection.check "$@"
}

ssh.tunnel.kill() {
    ssh.connection.kill "$@"
}

ssh.tunnel.restart() {
    local sshHostName="${1}"

    if ssh.connection.check "${sshHostName}" 1>/dev/null 2>&1; then
        ssh.connection.kill "${sshHostName}"
    fi

    ssh.tunnel.start "${sshHostName}"
}

############################################################
##  Completions for previous functions
############################################################

if [[ -n "${ZSH_VERSION:-}" ]]; then
    compdef ssh.connection.check=ssh
    compdef ssh.connection.kill=ssh
    compdef ssh.tunnel.start=ssh
    compdef ssh.tunnel.check=ssh
    compdef ssh.tunnel.kill=ssh
    compdef ssh.tunnel.restart=ssh
fi

if [[ -n "${BASH_VERSION:-}" ]]; then
    complete -F _ssh ssh.connection.check
    complete -F _ssh ssh.connection.kill
    complete -F _ssh ssh.tunnel.start
    complete -F _ssh ssh.tunnel.check
    complete -F _ssh ssh.tunnel.kill
    complete -F _ssh ssh.tunnel.restart
fi

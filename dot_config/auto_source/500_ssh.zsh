#shellcheck shell=bash

################################################################################
# Setup SSH helpers
################################################################################

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

################################################################################
##  Manage hardware token with SSH agent
################################################################################
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

################################################################################
##  Manage SSH tunnels
################################################################################
ssh.tunnel.start() {
    local sshHostName="${1}"

    ssh -fN "${sshHostName}"
}

ssh.tunnel.check() {
    local sshHostName="${1}"

    if ssh -O "check" "${sshHostName}" 1>/dev/null 2>&1; then
        printf "Tunnel is open\n"
    else
        printf "Tunnel is not open\n"
    fi
}

ssh.tunnel.kill() {
    local sshHostName="${1}"

    ssh -O "exit" "${sshHostName}"
}

ssh.tunnel.restart() {
    local sshHostName="${1}"

    if ssh.tunnel.check "${sshHostName}" 1>/dev/null 2>&1; then
        ssh.tunnel.kill "${sshHostName}"
    fi

    ssh.tunnel.start "${sshHostName}"
}

ssh.tunnel.list() {
    local tunnelDirectory="${HOME}/.ssh/tunnels"
    local tunnelCount="$(ll "${tunnelDirectory}" | wc -l )"

    printf -- "Tunnel count: %d\n" "${tunnelCount}"
    if [[ "${tunnelCount}" -gt 0 ]]; then
        printf -- "\n"
        ll "${tunnelDirectory}"
    fi
}
alias lltunnel="ssh.tunnel.list"

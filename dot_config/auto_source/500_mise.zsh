# shellcheck shell=bash

################################################################################
# Setup mise
################################################################################

# Attempt to install mise
if ! command -v mise 1>/dev/null 2>&1; then
    printf '################################################################################\n'
    printf '# Install mise\n'
    printf '################################################################################\n'
    curl -sS https://mise.run | sh
fi

# Exit if mise still not available
if ! command -v mise 1>/dev/null 2>&1; then
    return 0
fi

# Activate mise
eval "$(mise activate zsh)"

# Generate and install mise completions if not already installed
if [[ ! -f "${XDG_DATA_HOME}/zsh/site-functions/_mise" ]]; then
    mise completion zsh  > "${XDG_DATA_HOME}/zsh/site-functions/_mise"
fi

# Wrap mise so global set/unset/use/unuse writes to the chezmoi-managed file.
mise() {
    local env_config_file="${XDG_CONFIG_HOME}/mise/conf.d/500-env.toml"
    local tool_config_file="${XDG_CONFIG_HOME}/mise/conf.d/500-tools.toml"

    case "$1" in
        set|unset)
            _mise_rewrite_global_flag "--file" "${env_config_file}" "$@"
            ;;

        use|unuse)
            _mise_rewrite_global_flag "--path" "${tool_config_file}" "$@"
            ;;

        *)
            command mise "$@"
            ;;
    esac
}

_mise_rewrite_global_flag() {
    local replacement_flag="$1"
    local replacement_arg="$2"
    shift 2

    local -a args
    local arg
    local replaced=0

    for arg in "$@"; do
        case "${arg}" in
            -g|--global)
                args+=("${replacement_flag}" "${replacement_arg}")
                replaced=1
                ;;
            *)
                args+=("${arg}")
                ;;
        esac
    done

    command mise "${args[@]}"
}

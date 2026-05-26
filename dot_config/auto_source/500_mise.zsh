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

# Wrapper function to enforce a default file for 'mise set' and 'mise use'
mise() {
    # Check if the first argument is 'set'
    # Check if there are more than one arguments (to ensure there's something after 'set')
    # Check if the '--file' option is not present in the arguments
    if [[ "$1" == "set" ]] && [[ $# -gt 1 ]] && ! [[ " $* " =~ " --file[ =]?" ]]; then
        shift
        command mise set --file "${XDG_CONFIG_HOME}/mise/conf.d/500-env.toml" "$@"
    # Check if the first argument is 'use'
    # Check if the '--path' or '-p' option is not present in the arguments
    elif [[ "$1" == "use" ]] && ! [[ " $* " =~ " --path[ =]?" || " $* " =~ " -p[ =]?" ]]; then
        shift
        command mise use --path "${XDG_CONFIG_HOME}/mise/conf.d/900-tools.toml" "$@"
    # Check if the first argument is 'unuse'
    # Check if the '--path' or '-p' option is not present in the arguments
    elif [[ "$1" == "unuse" ]] && ! [[ " $* " =~ " --path[ =]?" || " $* " =~ " -p[ =]?" ]]; then
        shift
        command mise unuse --path "${XDG_CONFIG_HOME}/mise/conf.d/900-tools.toml" "$@"
    else
        command mise "$@"
    fi
}

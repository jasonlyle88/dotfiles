# shellcheck shell=bash

################################################################################
# Setup Python
################################################################################

# On linux machines, make sure the user podman socket is enabled:
# systemctl --user enable --now podman.socket

if ! command -v podman 1>/dev/null 2>&1; then
    return 0
fi

# Setup DOCKER_HOST to point to the podman socket
# This allows tools like docker-compose to work with podman
if DOCKER_HOST_VALUE="$(podman info --format '{{.Host.RemoteSocket.Path}}' 2>/dev/null)"; then

    if [[ "${DOCKER_HOST_VALUE}" != 'unix://'* ]]; then
        DOCKER_HOST_VALUE="unix://${DOCKER_HOST_VALUE}"
    fi
    export DOCKER_HOST="${DOCKER_HOST_VALUE}"

    if [[ "${OSTYPE}" == "darwin"* ]]; then
        # On macOS, we need to set the DOCKER_HOST environment variable for GUI apps as well
        launchctl setenv DOCKER_HOST "${DOCKER_HOST}"
    fi
fi

# do not show warning message that 'podman compose' is executing an external binary
# export PODMAN_COMPOSE_WARNING_LOGS=false

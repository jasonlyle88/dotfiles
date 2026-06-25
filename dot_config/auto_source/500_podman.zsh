# shellcheck shell=bash

################################################################################
# Setup Podman
################################################################################

# On linux machines, make sure the user podman socket is enabled:
# systemctl --user enable --now podman.socket

if ! command -v podman 1>/dev/null 2>&1; then
    return 0
fi

############################################################
# Docker compatibility
############################################################

# Setup DOCKER_HOST to point to the podman socket
# This allows tools like docker-compose to work with podman
PODMAN_SOCKET_PATH="$(podman machine info --format '{{.Host.EventsDir}}' 2>/dev/null)"
PODMAN_CURRENT_MACHINE="$(podman machine info --format '{{.Host.CurrentMachine}}' 2>/dev/null)"
PODMAN_CURRENT_MACHINE_STATE="$(podman machine info --format '{{.Host.MachineState}}' 2>/dev/null)"
DOCKER_HOST_VALUE=''

if [[ -z "${PODMAN_CURRENT_MACHINE}" ]]; then
    DOCKER_HOST_VALUE="${PODMAN_SOCKET_PATH}/podman.sock"
else
    DOCKER_HOST_VALUE="${PODMAN_SOCKET_PATH}/${PODMAN_CURRENT_MACHINE}-api.sock"
fi

if [[ -n "${PODMAN_CURRENT_MACHINE}" && "${PODMAN_CURRENT_MACHINE_STATE}" == "Running" && ! -e "${DOCKER_HOST_VALUE}" ]]; then
    printf -- "Podman machine '%s' is running, but the socket file '%s' does not exist. investigate.\n" "${PODMAN_CURRENT_MACHINE}" "${DOCKER_HOST_VALUE}" >&2
    DOCKER_HOST_VALUE=''
fi

if [[ -n "${DOCKER_HOST_VALUE}" && "${DOCKER_HOST_VALUE}" != 'unix://'* ]]; then
    DOCKER_HOST_VALUE="unix://${DOCKER_HOST_VALUE}"
fi

export DOCKER_HOST="${DOCKER_HOST_VALUE}"

# On macOS, we need to set the DOCKER_HOST environment variable for GUI apps as well
if [[ "${OSTYPE}" == "darwin"* ]]; then
    launchctl setenv DOCKER_HOST "${DOCKER_HOST}"
fi

############################################################
# Podman compose settings
############################################################

# do not show warning message that 'podman compose' is executing an external binary
# export PODMAN_COMPOSE_WARNING_LOGS=false

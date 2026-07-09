# shellcheck shell=bash

################################################################################
# Setup oci
################################################################################

if ! command -v oci 1>/dev/null 2>&1; then
    return 0
fi

# Configured based on values from documentation at
# https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/clienvironmentvariables.htm

export OCI_CLI_CONFIG_FILE="${XDG_CONFIG_HOME}/oci/config"
export OCI_CLI_RC_FILE="${XDG_CONFIG_HOME}/oci/oci_cli_rc"
export OCI_CLI_PROFILE='DEFAULT'

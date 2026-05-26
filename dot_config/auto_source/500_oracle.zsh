# shellcheck shell=bash

################################################################################
# Setup Oracle variables
################################################################################


#Add TNS_ADMIN for Oracle client configurations
export TNS_ADMIN="${XDG_CONFIG_HOME}/oracle"

# Add TNS_ADMIN to the MacOS launcher environment
if [[ "${OSTYPE}" == "darwin"* ]]; then
    launchctl setenv TNS_ADMIN "${TNS_ADMIN}"
fi

#Add SQLPATH for login.sql to modify default SQLcl
export SQLPATH="${XDG_CONFIG_HOME}/sqlcl"

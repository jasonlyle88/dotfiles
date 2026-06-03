# shellcheck shell=bash

################################################################################
# Setup functions to generate SQLCL aliases for TNS names and LDAP entries
################################################################################

# This script is designed to be able to be sourced in BASH or ZSH

function formatXgbuLdapAliasNames() {
    local aliasPrefix="${1}"
    local contextName="${2}"
    local databaseName="${3}"
    # shellcheck disable=2034
    local databaseConnectIdentifier="${4}"

    local databasePrefix='xgbu_ace_'

    # Remove the database prefix if the database name begins with that
    if [[ "${databaseName}" = "${databasePrefix}"* ]]; then
        databaseName="${databaseName#"${databasePrefix}"}"
    fi

    # Now remove the context name if the database name begins with that
    if [[ "${databaseName}" = "${contextName}_"* ]]; then
        databaseName="${databaseName#"${contextName}_"}"
    fi

    printf '%s%s.%s' \
        "${aliasPrefix}" \
        "${contextName}" \
        "${databaseName}"
} # formatXgbuLdapAliasNames

function additionalXgbuLdapAliases() {
    local aliasPrefix="${1}"
    local alias="${2}"
    local contextName="${3}"
    local databaseName="${4}"
    local databaseConnectIdentifier="${5}"


    local apexUrlBaseMethodToken='#METHOD#'
    local apexUrlBase="https://xgbu-ace-${apexUrlBaseMethodToken}.appoci.oraclecorp.com/ords"
    local -a apexUrlMethods=(
        'ords'
        'wtss'
    )

    local aliasBase
    local newAlias
    local isAdb
    local apexUrlDatabasePath
    local method
    local apexUrl

    aliasBase="apex.${alias#"sql."}"

    if [[ "${databaseConnectIdentifier}" == *'.adb.oraclecloud.com'* ]]; then
        isAdb='true'
    else
        isAdb='false'
    fi

    if [[ "${isAdb}" == 'true' ]]; then
        apexUrlDatabasePath="${databaseName}"
    else
        apexUrlDatabasePath="acedev/${databaseName}"
    fi

    for method in "${apexUrlMethods[@]}"; do
        newAlias="${aliasBase}.${method}"
        apexUrl="${apexUrlBase//${apexUrlBaseMethodToken}/${method}}/${apexUrlDatabasePath}/"

        # shellcheck disable=1003
        printf -- $'alias %s='\''open '\''\'\'''\''%s'\''\'\'''\'''\''\n' \
            "${newAlias}" \
            "${apexUrl}"
    done
} # additionalXgbuLdapAliases

function sql.generateAliases() {
    local cloudWallet
    local aliasFile
    local aliasPrefix
    local aliases
    local exitCode

    ############################################################################
    ##  TNS Names
    ############################################################################
    aliasFile="${PERSONAL_AUTOSOURCE_DIR}/900_sql_aliases_tns.zsh"
    aliases="$(
        sqlclGenerateTNSAliases -T
    )"
    exitCode=$?
    if [[ "${exitCode}" -eq 0 ]]; then
        printf '%s\n' "${aliases}" > "${aliasFile}"

        # shellcheck disable=1090
        source "${aliasFile}"
    fi

    ############################################################################
    ##  Cloud wallet: LYLEATP1
    ############################################################################
    cloudWallet="${TNS_ADMIN}/wallets/Wallet_lyleatp1.zip"
    aliasPrefix='sql.personal.dev.'
    aliasFile="${PERSONAL_AUTOSOURCE_DIR}/900_sql_aliases_lyleatp1.zsh"
    aliases="$(
        sqlclGenerateTNSAliases \
            -c "${cloudWallet}" \
            -p "${aliasPrefix}"
    )"
    exitCode=$?
    if [[ "${exitCode}" -eq 0 ]]; then
        printf '%s\n' "${aliases}" > "${aliasFile}"

        # shellcheck disable=1090
        source "${aliasFile}"
    fi

    ############################################################################
    ##  Cloud wallet: ORACLELYLEATP1
    ############################################################################
    cloudWallet="${TNS_ADMIN}/wallets/Wallet_oralyleatp1.zip"
    aliasPrefix='sql.personal.dev.'
    aliasFile="${PERSONAL_AUTOSOURCE_DIR}/900_sql_aliases_oralyleatp1.zsh"
    aliases="$(
        sqlclGenerateTNSAliases \
            -c "${cloudWallet}" \
            -p "${aliasPrefix}"
    )"
    exitCode=$?
    if [[ "${exitCode}" -eq 0 ]]; then
        printf '%s\n' "${aliases}" > "${aliasFile}"

        # shellcheck disable=1090
        source "${aliasFile}"
    fi

    ############################################################################
    ##  Cloud wallet: DBVNA
    ############################################################################
    cloudWallet="${TNS_ADMIN}/wallets/Wallet_DBVNA.zip"
    aliasPrefix='sql.vna.dev.'
    aliasFile="${PERSONAL_AUTOSOURCE_DIR}/900_sql_aliases_dbvna.zsh"
    aliases="$(
        sqlclGenerateTNSAliases \
            -c "${cloudWallet}" \
            -p "${aliasPrefix}"
    )"
    exitCode=$?
    if [[ "${exitCode}" -eq 0 ]]; then
        printf '%s\n' "${aliases}" > "${aliasFile}"

        # shellcheck disable=1090
        source "${aliasFile}"
    fi

    ############################################################################
    ##  Cloud wallet: HCGBUODRDEV
    ############################################################################
    cloudWallet="${TNS_ADMIN}/wallets/Wallet_hcgbuodrdev.zip"
    aliasPrefix='sql.oracle.hcgbu.dev.odr.'
    aliasFile="${PERSONAL_AUTOSOURCE_DIR}/900_sql_aliases_hcgbu_dev_odr.zsh"
    aliases="$(
        sqlclGenerateTNSAliases \
            -c "${cloudWallet}" \
            -p "${aliasPrefix}"
    )"
    exitCode=$?
    if [[ "${exitCode}" -eq 0 ]]; then
        printf '%s\n' "${aliases}" > "${aliasFile}"

        # shellcheck disable=1090
        source "${aliasFile}"
    fi

    ############################################################################
    ##  Cloud wallet: OHPEDEPHX1
    ############################################################################
    cloudWallet="${TNS_ADMIN}/wallets/Wallet_OHPEDEPHX1.zip"
    aliasPrefix='sql.oracle.hcgbu.dev.ohpo.'
    aliasFile="${PERSONAL_AUTOSOURCE_DIR}/900_sql_aliases_hcgbu_dev_ohpo.zsh"
    aliases="$(
        sqlclGenerateTNSAliases \
            -c "${cloudWallet}" \
            -p "${aliasPrefix}"
    )"
    exitCode=$?
    if [[ "${exitCode}" -eq 0 ]]; then
        printf '%s\n' "${aliases}" > "${aliasFile}"

        # shellcheck disable=1090
        source "${aliasFile}"
    fi

    ############################################################################
    ##  Cloud wallet: GPASDEVATP
    ############################################################################
    cloudWallet="${TNS_ADMIN}/wallets/Wallet_GPASDEVATP.zip"
    aliasPrefix='sql.oracle.hcgbu.dev.gpas.'
    aliasFile="${PERSONAL_AUTOSOURCE_DIR}/900_sql_aliases_hcgbu_dev_gpas.zsh"
    aliases="$(
        sqlclGenerateTNSAliases \
            -c "${cloudWallet}" \
            -p "${aliasPrefix}"
    )"
    exitCode=$?
    if [[ "${exitCode}" -eq 0 ]]; then
        printf '%s\n' "${aliases}" > "${aliasFile}"

        # shellcheck disable=1090
        source "${aliasFile}"
    fi

    ############################################################################
    ##  Cloud wallet: GPASUNSTABLEATP
    ############################################################################
    cloudWallet="${TNS_ADMIN}/wallets/Wallet_GPASUNSTABLEATP.zip"
    aliasPrefix='sql.oracle.hcgbu.unstable.gpas.'
    aliasFile="${PERSONAL_AUTOSOURCE_DIR}/900_sql_aliases_hcgbu_unstable_gpas.zsh"
    aliases="$(
        sqlclGenerateTNSAliases \
            -c "${cloudWallet}" \
            -p "${aliasPrefix}"
    )"
    exitCode=$?
    if [[ "${exitCode}" -eq 0 ]]; then
        printf '%s\n' "${aliases}" > "${aliasFile}"

        # shellcheck disable=1090
        source "${aliasFile}"
    fi

    ############################################################################
    ##  Cloud wallet: SchoolSafetyDemo
    ############################################################################
    cloudWallet="${TNS_ADMIN}/wallets/Wallet_SchoolSafetyDemo.zip"
    aliasPrefix='sql.oracle.lggiu.dev.schoolsafetydemo.'
    aliasFile="${PERSONAL_AUTOSOURCE_DIR}/900_sql_aliases_lggic_dev_schoolsafetydemo.zsh"
    aliases="$(
        sqlclGenerateTNSAliases \
            -c "${cloudWallet}" \
            -p "${aliasPrefix}"
    )"
    exitCode=$?
    if [[ "${exitCode}" -eq 0 ]]; then
        printf '%s\n' "${aliases}" > "${aliasFile}"

        # shellcheck disable=1090
        source "${aliasFile}"
    fi

    ############################################################################
    ##  LDAP: XGBU ACE DEV
    ############################################################################
    aliasFile="${PERSONAL_AUTOSOURCE_DIR}/900_sql_aliases_ldap_xgbu_dev.zsh"
    aliasPrefix='sql.oracle.xgbu_ace.dev.'
    aliases="$(
        sqlclGenerateOIDAliases \
            -p "${aliasPrefix}" \
            -f 'formatXgbuLdapAliasNames' \
            -a 'additionalXgbuLdapAliases' \
            -H "${XGBU_ACE_LDAP_HOST}" \
            -P "${XGBU_ACE_LDAP_PORT}" \
            -B "${XGBU_ACE_LDAP_BASE}" \
            -e 'oracleContext'
    )"
    exitCode=$?
    if [[ "${exitCode}" -eq 0 ]]; then
        printf '%s\n' "${aliases}" > "${aliasFile}"

        # shellcheck disable=1090
        source "${aliasFile}"
    fi

    ############################################################################
    ##  LDAP: XGBU ACE DEV TEST
    ############################################################################
    aliasFile="${PERSONAL_AUTOSOURCE_DIR}/900_sql_aliases_ldap_xgbu_dev_test.zsh"
    aliasPrefix='sql.oracle.xgbu_ace.dev.'
    aliases="$(
        sqlclGenerateOIDAliases \
            -p "${aliasPrefix}" \
            -f 'formatXgbuLdapAliasNames' \
            -a 'additionalXgbuLdapAliases' \
            -H "${XGBU_ACE_TEST_LDAP_HOST}" \
            -P "${XGBU_ACE_TEST_LDAP_PORT}" \
            -B "${XGBU_ACE_TEST_LDAP_BASE}" \
            -e 'oracleContext'
    )"
    exitCode=$?
    if [[ "${exitCode}" -eq 0 ]]; then
        printf '%s\n' "${aliases}" > "${aliasFile}"

        # shellcheck disable=1090
        source "${aliasFile}"
    fi
} # sql.generateAliases

function sql.generateConnections() {
    local cloudWallet

    ############################################################################
    ##  TNS Names
    ############################################################################
    sqlclGenerateTNSConnections -T -f 'TNS ADMIN' -u admin

    ############################################################################
    ##  Cloud wallet: LYLEATP1
    ############################################################################
    cloudWallet="${TNS_ADMIN}/wallets/Wallet_lyleatp1.zip"
    sqlclGenerateTNSConnections -c "${cloudWallet}" \
        -r 'Personal' \
        -u admin \
        -u jlyle

    ############################################################################
    ##  Cloud wallet: ORACLELYLEATP1
    ############################################################################
    cloudWallet="${TNS_ADMIN}/wallets/Wallet_oralyleatp1.zip"
    sqlclGenerateTNSConnections -c "${cloudWallet}" \
        -r 'Oracle' \
        -u admin

    ############################################################################
    ##  Cloud wallet: DBVNA
    ############################################################################
    cloudWallet="${TNS_ADMIN}/wallets/Wallet_DBVNA.zip"
    sqlclGenerateTNSConnections -c "${cloudWallet}" \
        -r 'Viscosity' \
        -u admin

    ############################################################################
    ##  Cloud wallet: HCGBUODRDEV
    ############################################################################
    cloudWallet="${TNS_ADMIN}/wallets/Wallet_hcgbuodrdev.zip"
    sqlclGenerateTNSConnections -c "${cloudWallet}" \
        -r 'Oracle' \
        -u admin

    ############################################################################
    ##  Cloud wallet: OHPEDEPHX1
    ############################################################################
    cloudWallet="${TNS_ADMIN}/wallets/Wallet_OHPEDEPHX1.zip"
    sqlclGenerateTNSConnections -c "${cloudWallet}" \
        -r 'Oracle' \
        -u admin

    ############################################################################
    ##  Cloud wallet: GPASDEVATP
    ############################################################################
    cloudWallet="${TNS_ADMIN}/wallets/Wallet_GPASDEVATP.zip"
    sqlclGenerateTNSConnections -c "${cloudWallet}" \
        -r 'Oracle' \
        -u admin

    ############################################################################
    ##  Cloud wallet: GPASUNSTABLEATP
    ############################################################################
    cloudWallet="${TNS_ADMIN}/wallets/Wallet_GPASUNSTABLEATP.zip"
    sqlclGenerateTNSConnections -c "${cloudWallet}" \
        -r 'Oracle' \
        -u admin

    ############################################################################
    ##  Cloud wallet: SchoolSafetyDemo
    ############################################################################
    cloudWallet="${TNS_ADMIN}/wallets/Wallet_SchoolSafetyDemo.zip"
    sqlclGenerateTNSConnections -c "${cloudWallet}" \
        -r 'Oracle' \
        -u admin

    ############################################################################
    ##  LDAP: XGBU ACE DEV
    ############################################################################
    sqlclGenerateOIDConnections \
        -H "${XGBU_ACE_LDAP_HOST}" \
        -P "${XGBU_ACE_LDAP_PORT}" \
        -B "${XGBU_ACE_LDAP_BASE}" \
        -r 'Oracle' \
        -u 'acdc' \
        -i 'platform'
        # -e 'oracleContext' # This takes too long, so just include platform for now

    ############################################################################
    ##  LDAP: XGBU ACE DEV TEST
    ############################################################################
    sqlclGenerateOIDConnections \
        -H "${XGBU_ACE_TEST_LDAP_HOST}" \
        -P "${XGBU_ACE_TEST_LDAP_PORT}" \
        -B "${XGBU_ACE_TEST_LDAP_BASE}" \
        -r 'Oracle' \
        -u 'acdc' \
        -e 'oracleContext'
} # sql.generateConnections

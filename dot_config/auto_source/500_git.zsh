# shellcheck shell=bash

################################################################################
# Setup git aliases and functions
################################################################################

alias gpskipci="git push -o 'ci.skip'"

git.branches() {
    local location="${1}"

    local currentBranch

    if [[ -z "${location}" ]]; then
        location="${PWD}"
    fi

    for dir in "${location:?}"/*/; do
        # Skip this loop iteration if it isn't a git repo
        if [[ ! -d "${dir}/.git" ]]; then
            continue
        fi

        currentBranch="$(git -C "${dir}" branch --show-current)"

        printf "%-50s: %s\n" "$(basename "${dir}")" "${currentBranch}"
    done
}

git.statuses() {
    local location="${1}"

    local headerFull="--------------------------------------------------------------------------------"
    local separator="--"
    local fetchOutput
    local fetchResult
    local behindAhead
    local behindCommits
    local aheadCommits
    local gitStatus

    if [[ -z "${location}" ]]; then
        location="${PWD}"
    fi

    for dir in "${location:?}"/*/; do
        # Skip this loop iteration if it isn't a git repo
        if [[ ! -d "${dir}/.git" ]]; then
            continue
        fi

        fetchOutput="$(git -C "${dir}" fetch 2>&1)"
        fetchResult=$?

        if [[ "${fetchResult}" -eq 0 ]]; then
            behindAhead="$(git -C "${dir}" rev-list --left-right --count "@{u}...")"
            behindCommits="$(printf "%s" "${behindAhead}" | grep -oE "^[0-9]+")"
            aheadCommits="$(printf "%s" "${behindAhead}" | grep -oE "[0-9]+$")"

            gitStatus="$(git -C "${dir}" status --short)"
        fi

        if [[ "${fetchResult}" -gt 0 ]] || [[ "${behindCommits}" -gt 0 ]] || [[ "${aheadCommits}" -gt 0 ]] || [[ -n "${gitStatus}" ]]; then
            printf "%s\n%s %s\n%s\n" "${headerFull}" "${separator}" "$(basename "${dir}")" "${headerFull}"

            if [[ "${fetchResult}" -gt 0 ]]; then
                printf "Fetch failed, unknown status\n\n"
                printf "%s\n\n" "${fetchOutput}"
            fi

            if [[ "${behindCommits}" -gt 0 ]] || [[ "${aheadCommits}" -gt 0 ]]; then
                printf "%-32s: %s\n" "Branch Name" "$(git -C "${dir}" branch --show-current)"
                printf "%-32s: %s\n" "Local behind by commits:" "${behindCommits}"
                printf "%-32s: %s\n" "Local ahead by commits:" "${aheadCommits}"
                printf "\n"
            fi

            if [[ -n "${gitStatus}" ]]; then
                printf "%s\n" "${gitStatus}"
                printf "\n"
            fi
        fi
    done
}

git.cleanupLocalBranches() {
    local location="${1}"

    local headerFull="--------------------------------------------------------------------------------"
    local separator="--"
    local fetchOutput
    local fetchResult
    local localBranchCleanupList

    if [[ -z "${location}" ]]; then
        location="${PWD}"
    fi

    for dir in "${location:?}"/*/; do
        # Skip this loop iteration if it isn't a git repo
        if [[ ! -d "${dir}/.git" ]]; then
            continue
        fi

        # Fetch to make sure everything is  up to date
        fetchOutput="$(git -C "${dir}" fetch --all 2>&1)"
        fetchResult=$?

        if [[ "${fetchResult}" -eq 0 ]]; then
            localBranchCleanupList="$(git -C "${dir}" branch -vv | grep ': gone]' | grep -v "^\s*\*" | awk '{ print $1; }')"
        fi

        if [[ "${fetchResult}" -gt 0 ]] || [[ -n "${localBranchCleanupList}" ]]; then
            printf "%s\n%s %s\n%s\n" "${headerFull}" "${separator}" "$(basename "${dir}")" "${headerFull}"

            if [[ "${fetchResult}" -gt 0 ]]; then
                printf "Fetch failed, unknown status\n\n"
                printf "%s\n\n" "${fetchOutput}"
            fi

            if [[ -n "${localBranchCleanupList}" ]]; then
                printf "%s" "${localBranchCleanupList}" | xargs -r git -C "${dir}" branch -D
                printf "\n"
            fi
        fi
    done
}

git.initBranch() {

    local h1="--------------------------------------------------------------------------------"
    local h2="----------------------------------------"
    local separator="--"

    local currentBranchName
    local defaultBranchName
    local commitCount
    local remoteExitCode

    printf -- '%s\n' "${h1}"
    printf -- '%s %s\n' "${separator}" "Get current branch"
    printf -- '%s\n' "${h1}"
    if ! currentBranchName="$(git branch --show-current)"; then
        printf -- 'Error getting current branch name\n' >&2
        return 1
    fi
    printf -- 'Branch name: %s\n' "${currentBranchName}"
    printf -- '\n'

    printf -- '%s\n' "${h1}"
    printf -- '%s %s\n' "${separator}" "Fetch all remote information"
    printf -- '%s\n' "${h1}"
    if ! git fetch --all 1>/dev/null 2>&1; then
        printf -- 'Error executing git fetch\n' >&2
        return 2
    fi
    printf -- 'Done\n'
    printf -- '\n'

    printf -- '%s\n' "${h1}"
    printf -- '%s %s\n' "${separator}" "Get branch's remote name"
    printf -- '%s\n' "${h1}"
    remoteName="$(git config --get "branch.${currentBranchName}.remote")"
    remoteExitCode="$?"

    if [[ "${remoteExitCode}" -gt 1 ]]; then
        printf -- 'Error: Unexpected error getting remote name\n' >&2
        return 4
    elif [[ "${remoteExitCode}" -eq 1 ]]; then
        remoteCount="$(git remote | wc -l)"

        if [[ "${remoteCount}" -eq 0 ]]; then
            printf -- 'Error: No remote setup for repo\n' >&2
            return 5
        elif [[ "${remoteCount}" -gt 1 ]]; then
            printf -- 'Error: Multiple remotes setup for repo, cannot automatically determine remote to use\n' >&2
            return 6
        fi

        remoteName="$(git remote)"
    fi
    printf -- 'Remote name: %s\n' "${remoteName}"
    printf -- '\n'

    printf -- '%s\n' "${h1}"
    printf -- '%s %s\n' "${separator}" "Get remote's default branch"
    printf -- '%s\n' "${h1}"
    if ! defaultBranchName="$(git symbolic-ref "refs/remotes/${remoteName}/HEAD" | sed "s|^refs/remotes/${remoteName}/||")"; then
        printf -- 'Error getting default branch name\n' >&2
        return 7
    fi
    printf -- 'Default branch name: %s\n' "${defaultBranchName}"
    printf -- '\n'

    printf -- '%s\n' "${h1}"
    printf -- '%s %s\n' "${separator}" "Check branch commit count"
    printf -- '%s\n' "${h1}"
    if ! commitCount="$(git rev-list --count "^${defaultBranchName}" "${currentBranchName}")"; then
        printf -- 'Error getting commit count for branch\n' >&2
        return 8
    fi
    printf -- 'Commit count: %s\n' "${commitCount}"
    printf -- '\n'

    if [[ "${commitCount}" -eq 0 ]]; then
        printf -- '%s\n' "${h2}"
        printf -- '%s %s\n' "${separator}" "Add empty branch initialization commit"
        printf -- '%s\n' "${h2}"
        git commit --allow-empty -m 'Branch initialization'
        printf -- '\n'
    fi

    printf -- '%s\n' "${h1}"
    printf -- '%s %s\n' "${separator}" "Preform branch initialization"
    printf -- '%s\n' "${h1}"

    if [[ "${commitCount}" -eq 0 && "${remoteExitCode}" -eq 0 ]]; then
        git push
    elif [[ "${remoteExitCode}" -eq 1 ]]; then
        git push --set-upstream "${remoteName}" "${currentBranchName}"
    else
        printf -- 'Nothing to do, branch already initialized\n'
    fi

}

################################################################################
# Setup git clone autocompletion based on ssh aliases
################################################################################

# Load git completion now, so _git exists.
autoload -Uz +X _git

# Save the original git completer once.
if (( $+functions[_git] && ! $+functions[_git-original] )); then
    functions[_git-original]=$functions[_git]
fi

_git_clone_ssh_hosts() {
    local -a ssh_hosts
    ssh_hosts=("${(@f)$(ssh.aliases)}")

    compadd -S ':' -d ssh_hosts -- "${ssh_hosts[@]}"
}

_git() {
    local ret=1

    # Preserve normal git completion.
    _git-original "$@" && ret=0

    # Add ssh config aliases only for: git clone <TAB>
    if [[ "${words[1]}" == "git" && "${words[2]}" == "clone" && "${CURRENT}" -eq 3 ]]; then
        _git_clone_ssh_hosts && ret=0
    fi

    return ret
}

compdef _git git

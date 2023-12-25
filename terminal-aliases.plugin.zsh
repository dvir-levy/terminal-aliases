# Description: Aliases for terminal, git, terraform and more
#
# Author: https://github.com/dvir-levy
# =============================================================================

function has_command() {
  which "$@" > /dev/null 2>&1
}

# Check if WORKSPACE_PATH is set
if [[ -z "$WORKSPACE_PATH" ]]; then
    echo "Error: WORKSPACE_PATH is not set. Please configure it in your environment."
    return 1
fi

# Terminal
alias ll='ls -lGHa'

# AWS
if has_command aws && has_command aws-sso-login; then
    alias gl="echo 'currently working with:' && head -n1 $HOME/.aws/config && aws-sso-login"
fi

# Define a function to set CD aliases
set_cd_aliases() {
    local workspace_path="$1"

    # Get a list of all repositories in the workspace path
    all_repositories=("$workspace_path"/*)

    # Set aliases for each repository
    for repo in "${all_repositories[@]}"; do
        repo_name=$(basename "$repo")
        alias "$repo_name"="cd $repo && ls -la"
    done
}
set_cd_aliases $WORKSPACE_PATH


# Terraform
if has_command terraform ; then
    alias tfall='terraform fmt -recursive $WORKSPACE_PATH'
    alias tf="terraform fmt -recursive"
    alias tia='ti && ta'
    alias tip='ti && tp'
    alias ta="terraform apply"
    alias td="terraform destroy"
    alias ti="terraform init"
    alias tia='ti && ta'
    alias tip='ti && tp'
    alias to="terraform output"
    alias tp="tfall && terraform plan"
    alias ts="terraform state"
    alias tu="terraform force-unlock -force"
    alias tv="terraform validate"
    alias cleanup='echo | find $WORKSPACE_PATH -type d -name .terraform | xargs rm -rf'
    alias renewproviders='rm -rf ./.terraform.lock.hcl && terraform providers lock -platform=linux_amd64  -platform=darwin_amd64'
fi

# git
if has_command git ; then
    alias gsu='submodule update --init --recursive'
    alias gcm='git checkout $(git_main_branch) && git pull'
    alias gam='function _gam() { git add -A && git commit --verbose -m "$*" && git push; }; _gam' # git add, commit and push all together. run: 'gam "this is commit"'
    alias dlb='stale_branch=$(git branch --show-current) && git checkout $(git_main_branch) && git pull && git branch -d $stale_branch' #delete local branch, checkout main and pull
    alias fullrebase='current_branch=$(git branch --show-current) && git checkout $(git_main_branch) && git pull && git checkout $current_branch && git rebase $(git_main_branch)' #rebase current branch, run 'git push -f' right after if there are no conflicts
    alias fullmerge='current_branch=$(git branch --show-current) && git checkout $(git_main_branch) && git pull && git checkout $current_branch && git merge $(git_main_branch)' #merge current branch, run 'git push -f' right after if there are no conflicts
    alias dlg='git fetch --prune && git branch --merged $(git_main_branch) | grep -v "^[ *]*$(git_main_branch)$" | xargs git branch -d' #delete local branches that were merged to main
fi

# creates new GitHub Pull Request. optional jira ticket id (e.g:1234). run: 'newpr test_pr 1234'
if has_command terraform && has_command git; then
    newpr() {
        BPurple='\033[1;35m'
        Color_Off='\033[0m'
        Green='\033[0;102m'

        echo "terraform format"
        tfall

        echo "${BPurple}git status:${Color_Off}"
        gst
        printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

        echo "${BPurple}switching to master and pull...${Color_Off}"
        git checkout $(git_main_branch)
        git pull
        printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

        echo "${BPurple}creating new branch...${Color_Off}"
        git branch "$1"
        git checkout "$1"
        printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

        echo "${BPurple}git status:${Color_Off}"
        gst
        printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

        echo "${BPurple}staging all commits...${Color_Off}"
        ga -A
        printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

        echo "${BPurple}git status:${Color_Off}"
        gst
        printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

        echo "${BPurple}commiting first commit...${Color_Off}"
        gc -m "$2 - $1"
        ga -A
        gc -m "$2 - $1"
        printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -

        echo "${BPurple}pushing branch to remote...${Color_Off}"
        RESULT=$(git push --set-upstream origin $1 2>&1 1>/dev/null | cat)
        printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' '*'
        printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' '*'
        HTTP=$(echo $RESULT | grep -o 'https://[0-9a-zA-Z.]*\/.*\S')
        echo "Opening GitHub to create new pr :)"
        echo "${Green}$HTTP${Color_Off}"
        sleep 2
        open $HTTP
        printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' '*'
        printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' '*'

        echo "${BPurple}git status:${Color_Off}"
        gst
        printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
    }
fi

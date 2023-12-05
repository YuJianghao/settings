alias gcl="git clone"
alias gpl="git pull"
# pull up/master with rebase
alias gpm="git pull up master --rebase"
alias gps="git push"
alias gb="git branch"
alias gco="git checkout"
alias gcb="git checkout -b"

# create branch from up/master with date prefix mmdd-<branch-name>, e.g. 230807-fix_something
function gcbmd() {
    TODAY=$(date +%y%m%d)
    BRANCH_NAME=$TODAY-$1
    git checkout -b $BRANCH_NAME up/master
}

# create branch with date prefix mmdd-<branch-name>, e.g. 230807-fix_something
function gcbd() {
    TODAY=$(date +%y%m%d)
    BRANCH_NAME=$TODAY-$1
    git checkout -b $BRANCH_NAME
}

# create branch from up/master
function gcbm() {
    git checkout -b $1 up/master
}

alias grb="git rebase"

function grbh() {
    git rebase -i head~$1
}

# delete local branches matching prefix
function gbc() {
    if [ -z "$1" ]; then
        echo "No branch prefix provided. The following branches will be deleted:"
        git branch | awk '$0 !~ /\*/ {print $1}'
        echo "Are you sure you want to delete these branches? (y/n) "
        read REPLY
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            git branch | awk '$0 !~ /\*/ {print $1}' | xargs git branch -d
            git remote prune origin
        fi
    else
        echo "The following branches will be deleted:"
        git branch | awk '$1 ~ /^'"$1"'/ && $0 !~ /\*/ {print $1}'
        echo "Are you sure you want to delete these branches? (y/n) "
        read REPLY
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            git branch | awk '$1 ~ /^'"$1"'/ && $0 !~ /\*/ {print $1}' | xargs git branch -d
            git remote prune origin
        fi
    fi
}

# force delete local branches matching prefix
function gbC() {
    if [ -z "$1" ]; then
        echo "No branch prefix provided. The following branches will be deleted:"
        git branch | awk '$0 !~ /\*/ {print $1}'
        echo "Are you sure you want to delete these branches? (y/n) "
        read REPLY
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            git branch | awk '$0 !~ /\*/ {print $1}' | xargs git branch -D
            git remote prune origin
        fi
    else
        echo "The following branches will be deleted:"
        git branch | awk '$1 ~ /^'"$1"'/ && $0 !~ /\*/ {print $1}'
        echo "Are you sure you want to delete these branches? (y/n) "
        read REPLY
        echo
        if [[ "$REPLY" =~ ^[Yy]$ ]]; then
            git branch | awk '$1 ~ /^'"$1"'/ && $0 !~ /\*/ {print $1}' | xargs git branch -D
            git remote prune origin
        fi
    fi
}

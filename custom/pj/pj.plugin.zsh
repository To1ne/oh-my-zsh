#!/bin/zsh

function pj() {
    cmd="cd"
    file=$1

    if [[ "open" == "$file" ]] then
        file=$2
        cmd=(${(s: :)EDITOR})
    fi

    for project in $PROJECT_PATHS; do
        if [[ -d $project/$file ]] then
            $cmd "$project/$file"
            unset project # Unset project var
            return
        fi
    done

    echo "No such project $1"
}

alias pjo="project open"

function _pj () {
    compadd `/bin/ls -l $PROJECT_PATHS 2>/dev/null | awk '{ print $9 }'`
}

compdef _pj pj

#!bash
_ti() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local tags=$(for t in `awk '/^i/ {print $4}' $TIMELOG`; do echo -n ${t}' '; done)
    # Work-around for colon completion from maven
    colonprefixes=${cur%"${cur##*:}"}
    COMPREPLY=( $(compgen -W '$tags'  -- $cur))
    local i=${#COMPREPLY[*]}
    while [ $((--i)) -ge 0 ]; do
       COMPREPLY[$i]=${COMPREPLY[$i]#"$colonprefixes"}
    done
}
complete -F _ti ti

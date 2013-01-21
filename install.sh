#!/usr/bin/sh

SCRIPT_NAME=`basename $0`
REPO_BASE=`dirname $0`

PRINTF=/usr/bin/printf
EXPR=/usr/bin/expr
MKDIR=/bin/mkdir
CP=/bin/cp
DIFF=/usr/bin/diff

[ ! -x $PRINTF ] && echo "$PRINTF not found" && exit 1
[ ! -x $EXPR ] && echo "$EXPR not found" && exit 1
[ ! -x $MKDIR ] && echo "$MKDIR not found" && exit 1
[ ! -x $CP ] && echo "$CP not found" && exit 1
[ ! -x $DIFF ] && echo "$DIFF not found" && exit 1

usage() {
    $PRINTF "usage: $SCRIPT_NAME [-h|-i|-u]\n\n"
    $PRINTF "Installs the Crashmaster Vim Configuration o_O\n"
}

install() {
    local result_indent=0
    local repo_rel_path=""
    local target_path=""

    for i in `find $REPO_BASE/vim*`
    do
        repo_rel_path=`echo $i | sed -n 's|.*/\(vim.*\)|\1|p'`
        target_path=~/.$repo_rel_path
        result_indent=`$EXPR 72 - \( 2 \* ${#repo_rel_path} \)`
        $PRINTF "repo::%s -> %s" "$repo_rel_path" "$target_path"

        # directories
        if [ -d $i -a ! -d $target_path ]
        then
            $MKDIR -p $target_path || exit 1
            $PRINTF "%*s\n" $result_indent "[MKDIR]"
        elif [ -d $i -a -d $target_path ]
        then
            $PRINTF "%*s\n" $result_indent "[SKIP]"
        fi

        # files
        if [ -f $i -a ! -f $target_path ]
        then
            $CP $i $target_path || exit 1
            $PRINTF "%*s\n" $result_indent "[COPY]"
        elif [ -f $i -a -f $target_path ]
        then
            if $DIFF -u $target_path $i > /dev/null 2>&1
            then
                $PRINTF "%*s\n" $result_indent "[SKIP]"
                continue
            fi
            while true
            do
                $PRINTF "\n"
                read -n 1 -p "  (d)iff, (o)verwrite, (s)kip or (q)uit? " tmp
                $PRINTF "\n"
                case $tmp in
                    d)
                        $PRINTF "\n"
                        $DIFF -u $target_path $i
                        ;;
                    o)
                        $PRINTF "repo::%s -> %s" "$repo_rel_path" "$target_path"
                        $CP $i $target_path || exit 1
                        $PRINTF "%*s\n" $result_indent "[COPY]"
                        break
                        ;;
                    s)
                        $PRINTF "repo::%s -> %s" "$repo_rel_path" "$target_path"
                        $PRINTF "%*s\n" $result_indent "[SKIP]"
                        break
                        ;;
                    q)
                        exit 0
                        ;;
                    *)
                        $PRINTF "    %s: incorrect choice" $tmp
                        ;;
                esac
            done
        fi
    done
}

uninstall() {
    $PRINTF "Muu!\n"
}

case "$@" in
    -h|--help)
        usage
        ;;
    -i|--install)
        install
        ;;
    -u|--uninstall)
        # TODO
        uninstall
        ;;
    *)
        $PRINTF "%s: incorrect option\n" $@
        usage
        exit 1
        ;;
esac


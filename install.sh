#!/usr/bin/sh

SCRIPT_NAME=`basename $0`
REPO_BASE=`dirname $0`

PRINTF=/usr/bin/printf
EXPR=/usr/bin/expr
MKDIR=/bin/mkdir
RMDIR=/bin/rmdir
CP=/bin/cp
RM=/bin/rm
DIFF=/usr/bin/diff
LS=/bin/ls
WC=/usr/bin/wc

# Check used tools for their availability
[ ! -x $PRINTF ] && echo "$PRINTF not found" && exit 1
[ ! -x $EXPR ] && echo "$EXPR not found" && exit 1
[ ! -x $MKDIR ] && echo "$MKDIR not found" && exit 1
[ ! -x $RMDIR ] && echo "$RMDIR not found" && exit 1
[ ! -x $CP ] && echo "$CP not found" && exit 1
[ ! -x $RM ] && echo "$RM not found" && exit 1
[ ! -x $DIFF ] && echo "$DIFF not found" && exit 1
[ ! -x $LS ] && echo "$LS not found" && exit 1
[ ! -x $WC ] && echo "$WC not found" && exit 1

usage() {
    $PRINTF "usage: $SCRIPT_NAME [-h|-i|-u]\n\n"
    $PRINTF "Installs the Crashmaster Vim Configuration o_O\n"
}

error_result() {
    $PRINTF "%*s\n" $1 "[ERROR]"
    exit 1
}

install() {
    local result_indent=0
    local target_path=""

    for i in `find $REPO_BASE/vim*`
    do
        target_path=~/.`echo $i | sed -n 's|.*/\(vim.*\)|\1|p'`
        result_indent=`$EXPR 72 - ${#target_path}`
        $PRINTF "  -> %s" "$target_path"

        # directories
        if [ -d $i -a ! -d $target_path ]
        then
            $MKDIR -p $target_path || error_result $result_indent
            $PRINTF "%*s\n" $result_indent "[MKDIR]"
        elif [ -d $i -a -d $target_path ]
        then
            $PRINTF "%*s\n" $result_indent "[EXISTS]"
        fi

        # files
        if [ -f $i -a ! -f $target_path ]
        then
            $CP $i $target_path || error_result $result_indent
            $PRINTF "%*s\n" $result_indent "[COPY]"
        elif [ -f $i -a -f $target_path ]
        then
            if $DIFF -u $target_path $i > /dev/null 2>&1
            then
                $PRINTF "%*s\n" $result_indent "[SAME]"
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
                        $PRINTF "  -> %s" "$target_path"
                        $CP $i $target_path || error_result $result_indent
                        $PRINTF "%*s\n" $result_indent "[COPY]"
                        break
                        ;;
                    s)
                        $PRINTF "  -> %s" "$target_path"
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
    local result_indent=0
    local repo_path=""
    local target_path=""

    while true
    do
        read -n 1 -p "Really (u)ninstall or (q)uit? " tmp
        case $tmp in
            u)
                $PRINTF "\n"
                break
                ;;
            q)
                $PRINTF "\n"
                exit 0
                ;;
            *)
                $PRINTF "\n  %s: incorrect choice\n" $tmp
                ;;
        esac
    done

    # files
    for i in `find $REPO_BASE/vim*`
    do
        [ ! -f $i ] && continue
        repo_path=`echo $i | sed -n 's|.*/\(vim.*\)|\1|p'`
        target_path=~/.$repo_path
        result_indent=`$EXPR 72 - ${#target_path}`
        if [ -f $target_path ]
        then
            $PRINTF "  -> %s" "$target_path"
            $RM $target_path || error_result $result_indent
            $PRINTF "%*s\n" $result_indent "[RM]"
        fi
    done

    # directories
    for i in `find $REPO_BASE/vim*`
    do
        [ ! -d $i ] && continue
        repo_path=`echo $i | sed -n 's|.*/\(vim.*\)|\1|p'`
        target_path=~/.$repo_path
        result_indent=`$EXPR 72 - ${#target_path}`
        $PRINTF "  -> %s" "$target_path"
        if [ `ls -a $target_path | wc -l` -lt 3 ]
        then
            $RMDIR $target_path || error_result $result_indent
            $PRINTF "%*s\n" $result_indent "[RMDIR]"
        else
            $PRINTF "%*s\n" $result_indent "[NOT EMPTY]"
        fi
    done
}

case "$@" in
    -h|--help)
        usage
        ;;
    -i|--install)
        install
        ;;
    -u|--uninstall)
        uninstall
        ;;
    *)
        $PRINTF "%s: incorrect option\n" $@
        usage
        exit 1
        ;;
esac


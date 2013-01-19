#!/usr/bin/sh

SCRIPT_NAME=`basename $0`
PRINTF=/usr/bin/printf
EXPR=/usr/bin/expr
MKDIR=/bin/mkdir
CP=/bin/cp

usage() {
    $PRINTF "usage: $SCRIPT_NAME [-h|-i|-u]\n\n"
    $PRINTF "Installs the Crashmaster Vim Configuration o_O\n"
}

install() {
    local result_indent=0

    for i in `find vim*`
    do
        result_indent=`$EXPR 72 - \( 2 \* ${#i} \)`
        $PRINTF "%s -> ~/.%s" $i $i

        # directories
        if [ -d $i -a ! -d  ~/.$i ]
        then
            $PRINTF "%*s\n" $result_indent "[MKDIR]"
            $MKDIR -p ~/.$i || exit 1
        elif [ -d $i -a -d  ~/.$i ]
        then
            $PRINTF "%*s\n" $result_indent "[SKIP]"
        fi

        # files
        if [ -f $i -a ! -f ~/.$i ]
        then
            $PRINTF "%*s\n" $result_indent "[COPY]"
            $CP $i ~/.$i || exit 1
        elif [ -f $i -a -f ~/.$i ]
        then
            if diff -u ~/.$i $i > /dev/null 2>&1
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
                        diff -u ~/.$i $i
                        ;;
                    o)
                        $PRINTF "%s -> ~/.%s%*s\n" $i $i $result_indent "[COPY]"
                        $CP $i ~/.$i || exit 1
                        break
                        ;;
                    s)
                        $PRINTF "%s -> ~/.%s%*s\n" $i $i $result_indent "[SKIP]"
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


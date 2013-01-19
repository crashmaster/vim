#!/usr/bin/sh

SCRIPT_NAME=`basename $0`

usage() {
    printf "usage: $SCRIPT_NAME [-h|-i|-u]\n\n"
    printf "Installs the Crashmaster Vim Configuration :-)\n"
}

install() {
    local result_indent=0

    for i in `find vim*`
    do
        result_indent=`expr 72 - \( 2 \* ${#i} \)`
        printf "%s -> ~/.%s" $i $i

        # directories
        if [ -d $i -a ! -d  ~/.$i ]
        then
            printf "%*s\n" $result_indent "[MKDIR]"
            \mkdir -p ~/.$i || exit 1
        elif [ -d $i -a -d  ~/.$i ]
        then
            printf "%*s\n" $result_indent "[SKIP]"
        fi

        # files
        if [ -f $i -a ! -f ~/.$i ]
        then
            printf "%*s\n" $result_indent "[COPY]"
            \cp $i ~/.$i || exit 1
        elif [ -f $i -a -f ~/.$i ]
        then
            if diff -u ~/.$i $i > /dev/null 2>&1
            then
                printf "%*s\n" $result_indent "[SKIP]"
                continue
            fi
            while true
            do
                printf "\n"
                read -n 1 -p "  (d)iff, (o)verwrite, (s)kip or (q)uit? " tmp
                printf "\n"
                case $tmp in
                    d)
                        printf "\n"
                        diff -u ~/.$i $i
                        ;;
                    o)
                        printf "%s -> ~/.%s%*s\n" $i $i $result_indent "[COPY]"
                        \cp $i ~/.$i || exit 1
                        break
                        ;;
                    s)
                        printf "%s -> ~/.%s%*s\n" $i $i $result_indent "[SKIP]"
                        break
                        ;;
                    q)
                        exit 1
                        ;;
                    *)
                        printf "    %s: incorrect choice" $tmp
                        ;;
                esac
            done
        fi
    done
}

uninstall() {
    printf "Muu!\n"
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
        printf "%s: incorrect option\n" $@
        usage
        exit 1
        ;;
esac


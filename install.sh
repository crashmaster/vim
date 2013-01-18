#!/usr/bin/sh

file_list() {
    for i in `find vim*`
    do
        echo $i
    done
}

# check_dir_create() {
#     local tmp_dir=""
#     tmp_dir=`mktemp -p ~/.vimrc.XXXXXXXXXX` || return 1
#     rm -rf $TMPFILE || return 1
#     return 0
# }

install() {
    local error_flag=0
    for i in `find vim*`
    do
        # Create directory when needed
        if [ -d $i -a ! -d  ~/.$i ]
        then
            echo " ~/.$i does NOT exist, call: mkdir -p ~/.$i"
        fi
        # Handle files
        if [ -f $i -a -f ~/.$i ]
        then
            echo "target file: ~/.$i exists"
            while true
            do
                read -p "(d)iff, (o)verwrite, overwrite (a)ll, (s)kip, (q)uit : " tmp
                case $tmp in
                    d)
                        diff -u $i ~/.$i
                        ;;
                    o)
                        echo "  original replaced"
                        break
                        ;;
                    s)
                        echo "  original kept"
                        break
                        ;;
                    q)
                        exit 1
                        ;;
                    *)
                        echo "incorrect choice"
                        ;;
                esac
            done
        fi
    done

    if [ 1 -eq $error_flag ]
    then
        echo "install failed, calling uninstall"
        uninstall
    fi
}

uninstall() {
    file_list
}

case "$@" in
    -h|--help)
        echo "help"
        ;;
    -i|--install)
        echo "install"
        install
        ;;
    -u|--uninstall)
        echo "uninstall"
        uninstall
        ;;
    *)
        echo "error"
        ;;
esac


#!/usr/bin/sh

file_list() {
    for i in `find vim*`
    do
        echo $i
    done
}

check_dir_create() {
    local tmp_dir=""
    tmp_dir=`mktemp -p ~/.vimrc.XXXXXXXXXX` || return 1
    rm -rf $TMPFILE || return 1
    return 0
}

install() {
    local err=0
    for i in `find vim*`
    do
        [ -d $i -a -r $i ] && echo "mkdir -p ~/.$i"
        [ -f $i -a -r $i ] && echo "cp -i $i ~/.$i"
    done

    while true
    do
        if [ 0 -ne check_write ]
        then
            err=1
            break
        fi

        break
    done
}

remove() {
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
    -r|--remove)
        echo "remove"
        remove
        ;;
    *)
        echo "error"
        ;;
esac


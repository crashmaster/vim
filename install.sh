#!/bin/sh

SCRIPT_NAME=$(basename ${0})
REPO_BASE=$(dirname $(readlink -e ${0}))

PRINTF="printf"
EXPR="expr"
MKDIR="mkdir"
RMDIR="rmdir"
LN="ln"
RM="rm"
DIFF="diff"
LS="ls"
FIND="find"
WC="wc"
SORT="sort"

PRETEND_MODE=0

check_used_tools() {
    # Check used tools for availability
    set ${PRINTF} ${EXPR} ${MKDIR} ${RMDIR} ${LN} ${RM} ${DIFF} ${LS} \
        ${FIND} ${WC} ${SORT}

    which which > /dev/null 2>&1 || exit 1
    for i in $@
    do
        which ${i} > /dev/null 2>&1 || exit 1
    done
}

usage() {
    ${PRINTF} "usage: ${SCRIPT_NAME} [-p] -h|-i|-u\n\n"
    ${PRINTF} "installs/uninstalls the Crashmaster Vim configuration\n"
}

print_result() {
    ${PRINTF} "%*s\n" "${1}" "[${2}]"
}

error_result() {
    print_result ${1} "ERROR"
    ${PRINTF} "%s\n" "${2}"
    exit 1
}

execute() {
    local indent=0
    local result_str=""
    local cmd_output=""

    indent=${1}
    shift
    result_str=${1}
    shift

    if [ 0 -eq $PRETEND_MODE ]
    then
        cmd_output=$($@ 2>&1) || error_result ${indent} "${cmd_output}"
        print_result ${indent} "${result_str}"
    else
        print_result ${indent} "PRETEND ${result_str}"
    fi
}

install() {
    local indent=0
    local target=""

    for source in $(${FIND} ${REPO_BASE}/vim*)
    do
        target=~/.$(echo ${source} | sed -n 's|.*/\(vim.*\)|\1|p')
        indent=$(${EXPR} 72 - ${#target})
        ${PRINTF} "  -> %s" "${target}"

        # directories
        if [ -d ${source} ] && [ ! -d ${target} ]
        then
            execute ${indent} "MKDIR" ${MKDIR} -p ${target}
            continue
        elif [ -d ${source} ] && [ -d ${target} ]
        then
            print_result ${indent} "EXISTS"
            continue
        fi

        # files
        if [ -f ${source} ] && [ ! -f ${target} ]
        then
            execute ${indent} "LINK" ${LN} -fs ${source} ${target}
            continue
        elif [ -f ${source} ] && [ -f ${target} ]
        then
            if ${DIFF} -u ${target} ${source} > /dev/null 2>&1
            then
                print_result ${indent} "SAME"
                continue
            fi
            while true
            do
                ${PRINTF} "\n(d)iff, (o)verwrite, (s)kip or (q)uit? "
                read tmp
                case ${tmp} in
                    d)
                        ${PRINTF} "\n"
                        ${DIFF} -u ${target} ${source}
                        ;;
                    o)
                        ${PRINTF} "  -> %s" "${target}"
                        execute ${indent} "LINK" ${LN} -fs ${source} ${target}
                        break
                        ;;
                    s)
                        ${PRINTF} "  -> %s" "${target}"
                        print_result ${indent} "SKIP"
                        break
                        ;;
                    q)
                        exit 0
                        ;;
                    *)
                        ${PRINTF} "    %s: incorrect choice" ${tmp}
                        ;;
                esac
            done
        fi
    done
}

uninstall() {
    local indent=0
    local target=""

    while true
    do
        ${PRINTF} "Really (u)ninstall or (q)uit? "
        read tmp
        case ${tmp} in
            u)
                break
                ;;
            q)
                exit 0
                ;;
            *)
                ${PRINTF} "  %s: incorrect choice\n" ${tmp}
                ;;
        esac
    done

    # files
    for i in $(${FIND} ${REPO_BASE}/vim*)
    do
        [ ! -f ${i} ] && continue
        target=~/.$(echo ${i} | sed -n 's|.*/\(vim.*\)|\1|p')
        [ ! -f ${target} ] && continue
        indent=$(${EXPR} 72 - ${#target})
        ${PRINTF} "  -> %s" "${target}"
        execute ${indent} "RM" ${RM} ${target}
    done

    # directories
    for i in $(${FIND} ${REPO_BASE}/vim* | ${SORT} -r)
    do
        [ ! -d ${i} ] && continue
        target=~/.$(echo ${i} | sed -n 's|.*/\(vim.*\)|\1|p')
        [ ! -d ${target} ] && continue
        indent=$(${EXPR} 72 - ${#target})
        ${PRINTF} "  -> %s" "${target}"
        if [ $(${LS} -a ${target} | ${WC} -l) -lt 3 ]
        then
            execute ${indent} "RMDIR" ${RMDIR} ${target}
        else
            print_result ${indent} "NOT EMPTY"
        fi
    done
}

main() {
    check_used_tools

    if [ "-p" = "$1" ] || [ "--pretend" = "$1" ]
    then
        PRETEND_MODE=1
        shift
    fi

    if [ 0 -eq $# ]
    then
        ${PRINTF} "${SCRIPT_NAME}: insufficient options\n"
        usage
        exit 1
    fi

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
            ${PRINTF} "%s: incorrect option\n" $@
            usage
            exit 1
            ;;
    esac
}

main $@

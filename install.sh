#!/usr/bin/sh

SCRIPT_NAME=`basename ${0}`
REPO_BASE=`dirname ${0}`

PRINTF="printf"
EXPR="expr"
MKDIR="mkdir"
RMDIR="rmdir"
CP="cp"
RM="rm"
DIFF="diff"
LS="ls"
FIND="find"
WC="wc"
SORT="sort"

check_used_tools() {
    # Check used tools for availability
    set ${PRINTF} ${EXPR} ${MKDIR} ${RMDIR} ${CP} ${RM} ${DIFF} ${LS} \
        ${FIND} ${WC} ${SORT}

    which which > /dev/null 2>&1 || exit 1
    for i in $@
    do
        which ${i} > /dev/null 2>&1 || exit 1
    done
}

usage() {
    ${PRINTF} "usage: ${SCRIPT_NAME} [-h|-i|-u]\n\n"
    ${PRINTF} "installs/uninstalls the Crashmaster Vim configuration\n"
}

print_result() {
    ${PRINTF} "%*s\n" "${1}" "${2}"
}

error_result() {
    print_result ${1} "[ERROR]"
    ${PRINTF} "%s\n" "${2}"
    exit 1
}

exec_command() {
    local result_indent=0
    local result_str=""
    local cmd_output=""

    result_indent=${1}
    shift
    result_str=${1}
    shift

    cmd_output=`$@ 2>&1` || error_result ${result_indent} "${cmd_output}"
    print_result ${result_indent} "${result_str}"
}

install() {
    local result_indent=0
    local target_path=""

    for i in `${FIND} ${REPO_BASE}/vim*`
    do
        target_path=~/.`echo ${i} | sed -n 's|.*/\(vim.*\)|\1|p'`
        result_indent=`${EXPR} 72 - ${#target_path}`
        ${PRINTF} "  -> %s" "${target_path}"

        # directories
        if [ -d ${i} -a ! -d ${target_path} ]
        then
            exec_command ${result_indent} "[MKDIR]" \
                         ${MKDIR} -p ${target_path}
            continue
        elif [ -d ${i} -a -d ${target_path} ]
        then
            print_result ${result_indent} "[EXISTS]"
            continue
        fi

        # files
        if [ -f ${i} -a ! -f ${target_path} ]
        then
            exec_command ${result_indent} "[COPY]" \
                         ${CP} ${i} ${target_path}
            continue
        elif [ -f ${i} -a -f ${target_path} ]
        then
            if ${DIFF} -u ${target_path} ${i} > /dev/null 2>&1
            then
                print_result ${result_indent} "[SAME]"
                continue
            fi
            while true
            do
                ${PRINTF} "\n"
                read -p "(d)iff, (o)verwrite, (s)kip or (q)uit? " tmp
                ${PRINTF} "\n"
                case ${tmp} in
                    d)
                        ${PRINTF} "\n"
                        ${DIFF} -u ${target_path} ${i}
                        ;;
                    o)
                        ${PRINTF} "  -> %s" "${target_path}"
                        exec_command ${result_indent} "[COPY]" \
                                     ${CP} ${i} ${target_path}
                        break
                        ;;
                    s)
                        ${PRINTF} "  -> %s" "${target_path}"
                        print_result ${result_indent} "[SKIP]"
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
    local result_indent=0
    local target_path=""

    while true
    do
        read -p "Really (u)ninstall or (q)uit? " tmp
        case ${tmp} in
            u)
                ${PRINTF} "\n"
                break
                ;;
            q)
                ${PRINTF} "\n"
                exit 0
                ;;
            *)
                ${PRINTF} "\n  %s: incorrect choice\n" ${tmp}
                ;;
        esac
    done

    # files
    for i in `${FIND} ${REPO_BASE}/vim*`
    do
        [ ! -f ${i} ] && continue
        target_path=~/.`echo ${i} | sed -n 's|.*/\(vim.*\)|\1|p'`
        [ ! -f ${target_path} ] && continue
        result_indent=`${EXPR} 72 - ${#target_path}`
        ${PRINTF} "  -> %s" "${target_path}"
        exec_command ${result_indent} "[RM]" \
                     ${RM} ${target_path}
    done

    # directories
    for i in `${FIND} ${REPO_BASE}/vim* | ${SORT} -r`
    do
        [ ! -d ${i} ] && continue
        target_path=~/.`echo ${i} | sed -n 's|.*/\(vim.*\)|\1|p'`
        [ ! -d ${target_path} ] && continue
        result_indent=`${EXPR} 72 - ${#target_path}`
        ${PRINTF} "  -> %s" "${target_path}"
        if [ `${LS} -a ${target_path} | ${WC} -l` -lt 3 ]
        then
            exec_command ${result_indent} "[RMDIR]" \
                         ${RMDIR} ${target_path}
        else
            print_result ${result_indent} "[NOT EMPTY]"
        fi
    done
}

main() {
    check_used_tools

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

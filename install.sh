#!/usr/bin/env bash

SCRIPT_NAME=$(basename "${0}")
REPO_BASE=$(dirname "$(readlink -e "${0}")")

PRETEND_MODE=0

PLUGINS=(
    "https://github.com/dense-analysis/ale.git"
    "https://github.com/tpope/vim-fugitive.git"
    "https://github.com/mustache/vim-mustache-handlebars.git"
    "https://github.com/neoclide/coc.nvim.git@release"
)
PACK_DIR="${HOME}/.vim/pack/plugins/start"

check_used_tools() {
    # Check used tools for availability
    set printf expr mkdir rmdir ln rm diff ls find wc sort git

    which which > /dev/null 2>&1 || exit 1
    for i in "$@"; do
        which "${i}" > /dev/null 2>&1 || exit 1
    done
}

usage() {
    printf "usage: ${SCRIPT_NAME} [-p] -h|-i|-u\n\n"
    printf "installs/uninstalls the Crashmaster Vim configuration\n"
}

print_result() {
    printf "%*s\n" "${1}" "[${2}]"
}

error_result() {
    print_result "${1}" "ERROR"
    printf "%s\n" "${2}"
    exit 1
}

execute() {
    local indent=0
    local result_str=""
    local cmd_output=""

    indent="${1}"
    shift
    result_str="${1}"
    shift

    if [ 0 -eq "$PRETEND_MODE" ]; then
        cmd_output=$("$@" 2>&1) || error_result "${indent}" "${cmd_output}"
        print_result "${indent}" "${result_str}"
    else
        print_result "${indent}" "PRETEND ${result_str}"
    fi
}

install_plugins() {
    if [ ! -d "${PACK_DIR}" ]; then
        execute 50 "MKDIR" mkdir -p "${PACK_DIR}"
    fi
    for entry in "${PLUGINS[@]}"; do
        local url="${entry%%@*}"
        local branch="${entry##*@}"
        [ "${branch}" = "${entry}" ] && branch=""
        local name
        name=$(basename "${url}" .git)
        local target="${PACK_DIR}/${name}"
        local indent
        indent=$(expr 72 - ${#target})
        printf "  -> %s" "${target}"
        if [ -d "${target}" ]; then
            print_result "${indent}" "EXISTS"
        else
            if [ -n "${branch}" ]; then
                execute "${indent}" "CLONE" \
                    git clone --depth 1 -b "${branch}" "${url}" "${target}"
            else
                execute "${indent}" "CLONE" \
                    git clone --depth 1 "${url}" "${target}"
            fi
        fi
    done
}

install() {
    local indent=0
    local target=""

    install_plugins

    for source in $(find "${REPO_BASE}"/vim*); do
        target=~/.$(echo "${source}" | sed -n 's|.*/\(vim.*\)|\1|p')
        indent=$(expr 72 - ${#target})
        printf "  -> %s" "${target}"

        # directories
        if [ -d "${source}" ] && [ ! -d "${target}" ]; then
            execute "${indent}" "MKDIR" mkdir -p "${target}"
            continue
        elif [ -d "${source}" ] && [ -d "${target}" ]; then
            print_result "${indent}" "EXISTS"
            continue
        fi

        # files
        if [ -f "${source}" ] && [ ! -f "${target}" ]; then
            execute "${indent}" "LINK" ln -fs "${source}" "${target}"
            continue
        elif [ -f "${source}" ] && [ -f "${target}" ]; then
            if diff -u "${target}" "${source}" > /dev/null 2>&1; then
                print_result "${indent}" "SAME"
                continue
            fi
            if [ 1 -eq "$PRETEND_MODE" ]; then
                print_result "${indent}" "PRETEND LINK"
                continue
            fi
            while true; do
                printf "\n(d)iff, (o)verwrite, (s)kip or (q)uit? "
                read tmp
                case ${tmp} in
                    d)
                        printf "\n"
                        diff -u "${target}" "${source}"
                        ;;
                    o)
                        printf "  -> %s" "${target}"
                        execute "${indent}" "LINK" \
                            ln -fs "${source}" "${target}"
                        break
                        ;;
                    s)
                        printf "  -> %s" "${target}"
                        print_result "${indent}" "SKIP"
                        break
                        ;;
                    q)
                        exit 0
                        ;;
                    *)
                        printf "    %s: incorrect choice" "${tmp}"
                        ;;
                esac
            done
        fi
    done
}

uninstall() {
    local indent=0
    local target=""

    while true; do
        printf "Really (u)ninstall or (q)uit? "
        read tmp
        case ${tmp} in
            u)
                break
                ;;
            q)
                exit 0
                ;;
            *)
                printf "  %s: incorrect choice\n" "${tmp}"
                ;;
        esac
    done

    # files
    for i in $(find "${REPO_BASE}"/vim*); do
        [ ! -f "${i}" ] && continue
        target=~/.$(echo "${i}" | sed -n 's|.*/\(vim.*\)|\1|p')
        [ ! -f "${target}" ] && continue
        indent=$(expr 72 - ${#target})
        printf "  -> %s" "${target}"
        execute "${indent}" "RM" rm "${target}"
    done

    # directories
    for i in $(find "${REPO_BASE}"/vim* | sort -r); do
        [ ! -d "${i}" ] && continue
        target=~/.$(echo "${i}" | sed -n 's|.*/\(vim.*\)|\1|p')
        [ ! -d "${target}" ] && continue
        indent=$(expr 72 - ${#target})
        printf "  -> %s" "${target}"
        if [ "$(ls -a "${target}" | wc -l)" -lt 3 ]; then
            execute "${indent}" "RMDIR" rmdir "${target}"
        else
            print_result "${indent}" "NOT EMPTY"
        fi
    done
}

main() {
    check_used_tools

    if [ "-p" = "$1" ] || [ "--pretend" = "$1" ]; then
        PRETEND_MODE=1
        shift
    fi

    if [ 0 -eq $# ]; then
        printf "${SCRIPT_NAME}: insufficient options\n"
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
            printf "%s: incorrect option\n" "$@"
            usage
            exit 1
            ;;
    esac
}

main "$@"

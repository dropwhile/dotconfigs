#!/usr/bin/env bash
DIR=$(dirname "${0}")
NDIR=$(cd "${DIR}/../" && pwd -P)
GLOBIGNORE="..;."

#######
### function defs
#######
dolink() {
    link_dir=$1
    dest_file=$2
    FFILE="$(basename "${dest_file}")"
    OFILE="${link_dir}/.${FFILE}"
    if [ -h "${OFILE}" ] && [ -e "${OFILE}" ]; then
        ## just run silently if it is already a symlink
        #echo "-> ${OFILE} is already linked" >&2
        diff -q "${OFILE}" "${2}" >/dev/null
        if [ $? -eq 1 ]; then
            echo ":> ${OFILE} links somewhere unexpected" >&2
        fi
    elif [ -h "${OFILE}" ] && [ ! -e "${OFILE}" ]; then
        # appears to be a borken symlink. just link it
        echo "x> ${OFILE} already exists, but is a broken a link" >&2
        echo "     overwriting broken symlink" >&2
        ln -f -s "${dest_file}" "${OFILE}"
    elif [ -f "${OFILE}" ] || [ -d "${OFILE}" ]; then
        echo "x> ${OFILE} already exists, but is not a link" >&2
        echo "     remove file and run again to link" >&2
    else
        echo "o> linking ${OFILE} to " >&2
        echo "     ${dest_file}" >&2
        ln -s "${dest_file}" "${OFILE}"
    fi
}

#######
### main
#######

## add dotfiles
for dotfile in ${NDIR}/dotfiles/*; do
    dolink "${HOME}" "$dotfile"
done

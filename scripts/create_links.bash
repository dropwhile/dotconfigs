#!/usr/bin/env bash
DIR=$(dirname "${0}")
NDIR=$(cd "${DIR}/../" && pwd -P)
GLOBIGNORE="..;."
for dotfile in ${NDIR}/dotfiles/*; do
    FFILE="$(basename "${dotfile}")"
    OFILE="${HOME}/${FFILE}"
    if [ -h "${OFILE}" ]; then
        ## just run silently if it is already a symlink
        #echo "-> ${OFILE} is already linked" >&2
        continue
    elif [ -f "${OFILE}" ] || [ -d "${OFILE}" ]; then
        echo "x> ${OFILE} already exists, but is not a link" >&2
        echo "     remove file and run again to link" >&2
    else
        echo "o> linking ${OFILE} to " >&2
        echo "     ${dotfile}" >&2
        ln -s "${dotfile}" "${OFILE}"
    fi
done

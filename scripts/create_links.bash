#!/usr/bin/env bash
DIR=$(dirname "${0}")
NDIR=$(cd "${DIR}/../" && pwd -P)
GLOBIGNORE="..;."
for dotfile in ${NDIR}/dotfiles/*; do
    FFILE="$(basename "${dotfile}")"
    OFILE="${HOME}/${FFILE}"
    if [ -h "${OFILE}" ]; then
        echo "x> ${OFILE} is already linked" >&2
    elif [ -f "${OFILE}" ] || [ -d "${OFILE}" ]; then
        echo "--> ${OFILE} already exists, but is not a link" >&2
        echo "   remove file and run again to link" >&2
    else
        echo "o> linking ${OFILE} to ${dotfile}" >&2
        ln -s "${dotfile}" "${OFILE}"
    fi
done

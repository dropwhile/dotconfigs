#!/usr/bin/env bash
DIR=$(dirname "${0}")
NDIR=$(cd "${DIR}/../" && pwd -P)
GLOBIGNORE="..;."
for dotfile in ${NDIR}/dotfiles/*; do
    FFILE="$(basename "${dotfile}")"
    OFILE="${HOME}/${FFILE}"
    if [ -h "${OFILE}" ]; then
        echo "${OFILE} is already linked"
    elif [ -f "${OFILE}" ] || [ -d "${OFILE}" ]; then
        echo "${OFILE} already exists, but is not a link"
        echo "remove file and run again to link"
    else
        echo "linking ${OFILE} to ${dotfile}"
        ln -s "${dotfile}" "${OFILE}"
    fi
done

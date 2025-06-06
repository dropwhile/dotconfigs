#!/bin/sh
DIR=$(dirname "${0}")
NDIR=$(cd "${DIR}/../" && pwd -P)
GLOBIGNORE="..;."

#######
### function defs
#######
dolink() {
    link_dir=$1
    dest_file=$2
    prefix=$3
    FFILE="$(basename "${dest_file}")"
    OFILE="${link_dir}/${prefix}${FFILE}"
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
        echo "     overwriting broken symlink ${OFILE} to " >&2
        echo "     ${dest_file}" >&2
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

create_dir() {
    if [ ! -d "${1}" ]; then
        if [ -n "${2}" ]; then
            mkdir -m ${2} -p "${1}"
        else
            mkdir -p "${1}"
        fi
    fi
}

#######
### main
#######

## add top level dotfiles
for dotfile in "${NDIR}/dotfiles/"*; do
    FFILE="$(basename "${dotfile}")"
    # if file starts with an _, then skip it.  this is used to deprecate/remove
    # certain files without removing the file from the directory
    # (eg. a trail removal)
    case $FFILE in _*)
        continue
    esac

    dolink "${HOME}" "$dotfile" "."
done

## deep link .config files
if ! type find >/dev/null 2>&1; then
    echo "missing 'find'; could not create .config entries" >&2
elif ! type sed >/dev/null 2>&1; then
    echo "missing 'sed'; could not create .config entries" >&2
else
    find "${NDIR}/config/" -type f | while read x; do
        DPATH="$(echo "$x" | sed "s|${NDIR}/config/|$HOME/.config/|")"
        DDIR="$(dirname "$DPATH")"
        FFILE="$(basename "${dotfile}")"
        if [ ! -d "$DDIR" ]; then
            mkdir -p "$DDIR"
        fi
        dolink "${DDIR}" "${x}"
    done
fi

# setup .local directory if it doesn't exist
create_dir "${HOME}/.cache"
create_dir "${HOME}/.local"
create_dir "${HOME}/.tmp" 750


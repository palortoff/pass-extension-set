#!/bin/bash

[[ $# -ne 3 ]] && die "Usage: $PROGRAM $COMMAND pass-name <key> <value>"

path="${1%/}"
check_sneaky_paths "$path"
set_gpg_recipients "$(dirname -- "$path")"
passfile="$PREFIX/$path.gpg"
set_git "$passfile"


__set() {
    local passfile="${1}"
    local key="${2}"
    local value="${3}"


    tmpdir #Defines $SECURE_TMPDIR
    local tmp_file_prev tmp_file_new
    tmp_file_prev="$(mktemp -u "$SECURE_TMPDIR/XXXXXX")-${path//\//-}.txt"
    tmp_file_new="$(mktemp -u "$SECURE_TMPDIR/XXXXXX")-${path//\//-}.txt"

    $GPG -d  "${GPG_OPTS[@]}" "$passfile"  > "$tmp_file_prev" || exit 1
    action="Edit"

    if grep -q "^${key}:" "${tmp_file_prev}" ; then
        sed "s/^${key}:.*/${key}: ${value}/g" "${tmp_file_prev}" > "$tmp_file_new"
    else
        cp "${tmp_file_prev}"  "$tmp_file_new"
        echo "${key}: ${value}" >> "$tmp_file_new"
    fi

    while ! $GPG -e "${GPG_RECIPIENT_ARGS[@]}" -o "$passfile" "${GPG_OPTS[@]}" "$tmp_file_new"; do
        yesno "GPG encryption failed. Would you like to try again?"
    done
    git_add_file "$passfile" "$action password for $path using pass set."
}


if [[ -f $passfile ]]; then
    __set "$passfile" "$2" "$3"
elif [[ -z $path ]]; then
    die ""
else
    die "Error: $path is not in the password store."
fi

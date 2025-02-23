#!/bin/bash

SRC="/usr/src/netdata.git"
DST="/usr/src/binary-packages.git"

# load functions
. "${SRC}/packaging/installer/functions.sh" || exit 1

# fail if any command fails
set -e

cd "${SRC}"

# fetch the latest source, overwriting any changes made
run git fetch --all
run git reset --hard origin/master
run git pull

# make sure it works
run ./netdata-installer.sh --dont-wait

# build the static netdata
run ./packaging/makeself/build-x86_64-static.sh

# read the latest file generated
latest=$(run readlink "${SRC}/netdata-latest.gz.run")

[ -z "${latest}" ] && echo >&2 "Cannot find the latest staticaly built file" && exit 1

[ ! -f "${latest}" ] && echo >&2 "Latest statically built file ${latest}, does not exist." && exit 1

run cp "${SRC}/${latest}" "${DST}/${latest}"
run cd "${DST}"

[ -f netdata-latest.gz.run ] && run rm -f netdata-latest.gz.run
run ln -s "${latest}" netdata-latest.gz.run

run git add "${latest}"
run git commit -a -m "added ${latest}"
run git push

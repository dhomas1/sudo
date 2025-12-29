### SUDO ###
_build_sudo() {
local VERSION="1.9.17p2"
local FOLDER="sudo-${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="https://www.sudo.ws/sudo/dist/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
./configure --host="${HOST}" --prefix="${DEST}" --sysconfdir="${DEST}/etc" --mandir="${DEST}/man" --with-vardir="/tmp/DroboApps/${NAME}/var" --with-iologdir="${DEST}/var/log/sudo-io" --with-rundir="/tmp/DroboApps/${NAME}/run" --with-editor="/bin/vi" --without-systemd
make
make install install_uid=$(id -u) install_gid=$(id -g)
mv "${DEST}/etc/sudoers" "${DEST}/etc/sudoers.orig"
mkdir -p "${DEST}/var/log/sudo-io"
popd
}

### BUILD ###
_build() {
  _build_sudo
  _package
}

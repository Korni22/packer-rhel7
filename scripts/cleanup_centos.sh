# Clean up unneeded packages.
yum remove -y alsa-tools-firmware linux-firmware alsa-libs libsysfs centos-logos
yum -y clean all

rm -rf /usr/share/backgrounds

# remove unneeded languages
find /usr/share/locale -maxdepth 1 -mindepth 1 -type d | grep -v -e "en_US" | xargs rm -rf
localedef --list-archive | grep -v -e "en_US" | xargs localedef --delete-from-archive
mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl
build-locale-archive

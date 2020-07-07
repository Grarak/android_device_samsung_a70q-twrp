#!/sbin/sh

relink() {
	fname=$(basename "$1")
	target="/sbin/$fname"
	sed 's|/system/bin/linker64|///////sbin/linker64|' "$1" > "$target"
	chmod 755 $target
}

mkdir /s
mkdir /v
mount -t ext4 -o ro /dev/block/bootdevice/by-name/system /s
mount -t ext4 -o ro /dev/block/bootdevice/by-name/vendor /v

if [ -f /s/system/build.prop ]; then
	osver=$(grep -i 'ro.build.version.release' /s/system/build.prop  | cut -f2 -d'=')
	patchlevel=$(grep -i 'ro.build.version.security_patch' /s/system/build.prop  | cut -f2 -d'=')
	setprop ro.build.version.release "$osver"
	setprop ro.build.version.security_patch "$patchlevel"
else
	# Be sure to increase the PLATFORM_VERSION in build/core/version_defaults.mk to override Google's anti-rollback features to something rather insane
	osver=$(getprop ro.build.version.release_orig)
	patchlevel=$(getprop ro.build.version.security_patch_orig)
	setprop ro.build.version.release "$osver"
	setprop ro.build.version.security_patch "$patchlevel"
fi

ln -s /firmware /vendor/firmware_mnt

if [ -f /s/system/framework/samsungkeystoreutils.jar ]; then
	setprop keymaster.force true
fi

umount /v
umount /s
rmdir /v
rmdir /s
setprop crypto.ready 1

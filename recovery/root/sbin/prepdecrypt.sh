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

relink /v/bin/hw/android.hardware.gatekeeper@1.0-service
if [ -f /v/bin/hw/android.hardware.keymaster@4.0-service.samsung ]; then
	relink /v/bin/hw/android.hardware.keymaster@4.0-service.samsung
	mv /sbin/android.hardware.keymaster@4.0-service.samsung /sbin/android.hardware.keymaster@4.0-service
else
	relink /v/bin/hw/android.hardware.keymaster@4.0-service
fi
relink /v/bin/qseecomd

mkdir -p /vendor/lib64/hw
cp /v/lib64/hw/android.hardware.gatekeeper@1.0-impl.so /vendor/lib64/hw/
cp /v/lib64/hw/gatekeeper.mdfpp.so /vendor/lib64/hw/
cp /v/lib64/hw /vendor/lib64/
cp /v/lib64/libdiag.so /vendor/lib64/
cp /v/lib64/libdrmfs.so /vendor/lib64/
cp /v/lib64/libdrmtime.so /vendor/lib64/
cp /v/lib64/libdsutils.so /vendor/lib64/
cp /v/lib64/libGPreqcancel.so /vendor/lib64/
cp /v/lib64/libGPreqcancel_svc.so /vendor/lib64/
cp /v/lib64/libidl.so /vendor/lib64/
cp /v/lib64/libkeymaster4.so /vendor/lib64/
cp /v/lib64/libkeymasterdeviceutils.so /vendor/lib64/
cp /v/lib64/libkeymaster_helper_vendor.so /vendor/lib64/
cp /v/lib64/libkeymasterprovision.so /vendor/lib64/
cp /v/lib64/libkeymasterutils.so /vendor/lib64/
cp /v/lib64/libmdmdetect.so /vendor/lib64/
cp /v/lib64/libqdutils.so /vendor/lib64/
cp /v/lib64/libqisl.so /vendor/lib64/
cp /v/lib64/libqmi_cci.so /vendor/lib64/
cp /v/lib64/libqmi_client_qmux.so /vendor/lib64/
cp /v/lib64/libqmi_common_so.so /vendor/lib64/
cp /v/lib64/libqmi_encdec.so /vendor/lib64/
cp /v/lib64/libqmiservices.so /vendor/lib64/
cp /v/lib64/libQSEEComAPI.so /vendor/lib64/
cp /v/lib64/libqservice.so /vendor/lib64/
cp /v/lib64/libqtikeymaster4.so /vendor/lib64/
cp /v/lib64/librpmb.so /vendor/lib64/
cp /v/lib64/libSecureUILib.so /vendor/lib64/
cp /v/lib64/libsecureui.so /vendor/lib64/
cp /v/lib64/libsecureui_svcsock.so /vendor/lib64/
cp /v/lib64/libskeymaster4device.so /vendor/lib64/
cp /v/lib64/libssd.so /vendor/lib64/
cp /v/lib64/libStDrvInt.so /vendor/lib64/
cp /v/lib64/libtime_genoff.so /vendor/lib64/
cp /v/lib64/vendor.qti.hardware.tui_comm@1.0.so /vendor/lib64/

ln -s /firmware /vendor/firmware_mnt

if [ -f /s/system/framework/samsungkeystoreutils.jar ]; then
	setprop keymaster.force true
fi

umount /v
umount /s
rmdir /v
rmdir /s
setprop crypto.ready 1

#
# Copyright (C) 2019 The TwrpBuilder Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a73
TARGET_USES_64_BIT_BINDER := true

ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

ALLOW_MISSING_DEPENDENCIES := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := sm6150
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true

# Platform
TARGET_BOARD_PLATFORM := sm6150
TARGET_BOARD_PLATFORM_GPU := qcom-adreno612

# Kernel
BOARD_KERNEL_CMDLINE := console=null androidboot.hardware=qcom androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm_rtb.filter=0x237 service_locator.enable=1 swiotlb=1 androidboot.usbcontroller=a600000.dwc3 nokaslr printk.devkmsg=on
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_OFFSET      := 0x00008000
BOARD_KERNEL_TAGS_OFFSET := 0x01e00000
BOARD_RAMDISK_OFFSET     := 0x02000000
BOARD_SECOND_OFFSET      := 0x00f00000
BOARD_NAME               := SRPRL06C001
BOARD_HEADER_VERSION     := 1
BOARD_MKBOOTIMG_ARGS     := --kernel_offset $(BOARD_KERNEL_OFFSET) --ramdisk_offset $(BOARD_RAMDISK_OFFSET) --tags_offset $(BOARD_KERNEL_TAGS_OFFSET) --second_offset $(BOARD_SECOND_OFFSET) --header_version $(BOARD_HEADER_VERSION) --board $(BOARD_NAME)
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_SOURCE := kernel/samsung/a70q
TARGET_KERNEL_CONFIG := a70q_defconfig
BOARD_KERNEL_SEPARATED_DTBO := true
TARGET_KERNEL_CLANG_COMPILE := true

# QCOM
TARGET_USE_SDCLANG := true

# Avb
BOARD_AVB_ENABLE := true
ifeq ($(BOARD_AVB_ENABLE), true)
   BOARD_AVB_RECOVERY_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
   BOARD_AVB_RECOVERY_ALGORITHM := SHA256_RSA2048
   BOARD_AVB_RECOVERY_ROLLBACK_INDEX := 1
   BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 1
endif

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_DTBOIMG_PARTITION_SIZE := 10485760
BOARD_CACHEIMAGE_PARTITION_SIZE := 419430400
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 82825216
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 5767168000
BOARD_USERDATAIMAGE_PARTITION_SIZE := 119370772480
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_PARTITION_SIZE := 1048576000

# System as root
BOARD_BUILD_SYSTEM_ROOT_IMAGE := true
BOARD_ROOT_EXTRA_FOLDERS := bluetooth dsp firmware persist
BOARD_SUPPRESS_SECURE_ERASE := true

# File systems
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Workaround for error copying vendor files to recovery ramdisk
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_INCLUDE_RECOVERY_DTBO := true
LZMA_RAMDISK_TARGETS := recovery

# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_FBE := true

# TWRP specific build flags
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_USE_TOOLBOX := true
TW_NO_LEGACY_PROPS := true
TW_MAX_BRIGHTNESS := 255
TW_DEFAULT_BRIGHTNESS := 180
TW_NO_REBOOT_BOOTLOADER := true
TW_HAS_DOWNLOAD_MODE := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_Y_OFFSET := 77
TW_H_OFFSET := -77
TW_CUSTOM_CPU_TEMP_PATH := "/sys/class/thermal/thermal_zone16/temp"
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/config/usb_gadget/g1/functions/mass_storage.0/lun.%d/file"
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TW_CRYPTO_SYSTEM_VOLD_DEBUG := true
TW_SCREEN_BLANK_ON_BOOT := true
TW_HAS_EDL_MODE := true

# Hack: prevent anti rollback
PLATFORM_SECURITY_PATCH := 2099-12-31

#
# Copyright (C) 2015 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

LOCAL_PATH := device/htc/memul

BOARD_VENDOR := htc

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8226
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := msm8226
TARGET_BOARD_PLATFORM_GPU := qcom-adreno305
MALLOC_SVELTE := true
TARGET_NEEDS_GCC_LIBC := true

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := krait
TARGET_CPU_MEMCPY_BASE_OPT_DISABLE := true

# Kernel
BOARD_CUSTOM_BOOTIMG_MK := device/htc/memul/mkbootimg.mk
BOARD_DTBTOOL_ARGS := --dt-tag "htc,project-id = <"
BOARD_KERNEL_CMDLINE := console=none androidboot.hardware=qcom user_debug=31 ehci-hcd.park=3 zcache
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_SEPARATED_DT := true
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x02008000 --tags_offset 0x01e00000
TARGET_KERNEL_CONFIG := lineageos_memul_defconfig
TARGET_KERNEL_SOURCE := kernel/htc/msm8974

# QCOM hardware
BOARD_USES_QCOM_HARDWARE := true

# Audio
BOARD_USES_ALSA_AUDIO := true
AUDIO_FEATURE_ENABLED_COMPRESS_VOIP := false
AUDIO_FEATURE_ENABLED_HWDEP_CAL := true
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true
AUDIO_FEATURE_ENABLED_NEW_SAMPLE_RATE := true
AUDIO_FEATURE_LOW_LATENCY_PRIMARY := true
USE_CUSTOM_AUDIO_POLICY := 1

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/htc/memul/bluetooth

# Boot animation
TARGET_BOOTANIMATION_HALF_RES := true

# Camera
TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS := true
TARGET_SPECIFIC_CAMERA_PARAMETER_LIBRARY := libcamera_parameters_ext
USE_DEVICE_SPECIFIC_CAMERA := true
TARGET_HAS_LEGACY_CAMERA_HAL1 := true

# Charge mode
BOARD_CHARGING_MODE_BOOTING_LPM := /sys/htc_lpm/lpm_mode

# FM Radio
AUDIO_FEATURE_ENABLED_FM_POWER_OPT := true
BOARD_HAVE_QCOM_FM := true
TARGET_QCOM_NO_FM_FIRMWARE := true

# Graphics
TARGET_USES_ION := true
USE_OPENGL_RENDERER := true
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so
MAX_EGL_CACHE_KEY_SIZE := 12*1024
MAX_EGL_CACHE_SIZE := 2048*1024
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Power
TARGET_POWERHAL_VARIANT := qcom

# RIL
TARGET_RIL_VARIANT := caf

# RPC
TARGET_NO_RPC := true

# SDClang
TARGET_USE_SDCLANG := true
 
# Time services
BOARD_USES_QC_TIME_SERVICES := true

# Wifi
BOARD_HAS_QCOM_WLAN := true
BOARD_WLAN_DEVICE := qcwcn
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_$(BOARD_WLAN_DEVICE)
WIFI_DRIVER_FW_PATH_STA := "sta"
WIFI_DRIVER_FW_PATH_AP := "ap"

# Filesystem
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_CACHEIMAGE_PARTITION_SIZE := 369098752
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2818572288
BOARD_USERDATAIMAGE_PARTITION_SIZE := 3355443200
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Recovery
#RECOVERY_VARIANT := twrp
BOARD_GLOBAL_CFLAGS := -DBOARD_RECOVERY_BLDRMSG_OFFSET=2048
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_SELECT_BUTTON := true
BOARD_USES_MMCUTILS := true
TARGET_RECOVERY_DEVICE_DIRS += device/htc/memul/
TARGET_RECOVERY_DEVICE_MODULES += chargeled

# Hardware
BOARD_HARDWARE_CLASS += hardware/cyanogen/cmhw

# Tap to Wake
TARGET_TAP_TO_WAKE_NODE := "/sys/android_touch/doubletap2wake"

# Includes
TARGET_SPECIFIC_HEADER_PATH := device/htc/memul/include

# NFC
BOARD_NFC_CHIPSET := pn547

#TWRP
ifeq ($(RECOVERY_VARIANT),twrp)
  TW_INCLUDE_CRYPTO := true
  TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
  TW_INCLUDE_NTFS_3G := true
  TWRP_INCLUDE_LOGCAT := true
  TW_THEME := portrait_hdpi
  TARGET_RECOVERY_FSTAB := device/htc/memul/rootdir/etc/twrp.fstab
  RECOVERY_GRAPHICS_USE_LINELENGTH := true
  TARGET_USE_CUSTOM_LUN_FILE_PATH := /sys/devices/platform/msm_hsusb/gadget/lun%d/file
  RECOVERY_SDCARD_ON_DATA := true
  BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
else
  TARGET_RECOVERY_FSTAB := device/htc/memul/rootdir/etc/fstab.qcom
endif

# SELinux
include device/qcom/sepolicy/sepolicy.mk
BOARD_SEPOLICY_DIRS += device/htc/memul/sepolicy

#Note: Verursacht im moment merkwürdige probleme
# Enable dex-preoptimization to speed up first boot sequence
#ifeq ($(HOST_OS),linux)
#WITH_DEXPREOPT := true
#DONT_DEXPREOPT_PREBUILTS := true
#endif

# inherit from the proprietary version
-include vendor/htc/memul/BoardConfigVendor.mk

#
# system properties for memul
#

# RIL
PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/vendor/lib/libril-qc-qmi-1.so \
    rild.libargs=-d /dev/smd0 \
    ril.subscription.types=NV,RUIM \
    ro.baseband.arch=msm \
    ro.data.large_tcp_window_size=true \
    ro.telephony.call_ring.multiple=false \
    ro.telephony.default_network=9 \
    ro.use_data_netmgrd=true \
    persist.data.netmgrd.qos.enable=true \
    persist.radio.apm_sim_not_pwdn=1 \
    persist.radio.jbims=1 \
    telephony.lteOnGsmDevice=1 \
    ro.ril.def.agps.mode=1 \
    ro.ril.enable.a52=0 \
    ro.ril.enable.a53=1 \
    ro.ril.enable.dtm=0 \
    ro.ril.hsdpa.category=24 \
    ro.ril.hsupa.category=6 \
    ro.ril.hsxpa=4 \
    ro.ril.fast.dormancy.rule=1 \
    ro.ril.enable.amr.wideband=1 \
    ro.ril.enable.managed.roaming=1 \
    ro.ril.enable.sdr=1 \
    ro.ril.enable.r8fd=1 \
    ro.ril.disable.cpc=1 \
    ro.ril.enable.pre_r8fd=1 \
    DEVICE_PROVISIONED=1


# NITZ
PRODUCT_PROPERTY_OVERRIDES += \
    persist.rild.nitz_plmn="" \
    persist.rild.nitz_long_ons_0="" \
    persist.rild.nitz_long_ons_1="" \
    persist.rild.nitz_long_ons_2="" \
    persist.rild.nitz_long_ons_3="" \
    persist.rild.nitz_short_ons_0="" \
    persist.rild.nitz_short_ons_1="" \
    persist.rild.nitz_short_ons_2="" \
    persist.rild.nitz_short_ons_3=""

# QCOM
PRODUCT_PROPERTY_OVERRIDES += \
    com.qc.hardware=true \
    persist.thermal.monitor=true \
    ro.qc.sdk.sensors.gestures=true \
    ro.vendor.extension_library=/vendor/lib/libqti-perfd-client.so

# Audio
PRODUCT_PROPERTY_OVERRIDES += \
    af.fast_track_multiplier=1 \
    audio_hal.period_size=192 \
    av.offload.enable=false \
    tunnel.audio.encode=true \
    use.voice.path.for.pcm.voip=false

# fluencetype can be "fluence" or "fluencepro" or "none"
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qc.sdk.audio.fluencetype=fluence

PRODUCT_PROPERTY_OVERRIDES += \
    persist.audio.fluence.voicecall=true \
    persist.audio.fluence.speaker=true

# Media
PRODUCT_PROPERTY_OVERRIDES += \
    media.aac_51_output_enabled=true \
    mm.enable.smoothstreaming=true

# GPS
PRODUCT_PROPERTY_OVERRIDES += \
    persist.gps.qc_nlp_in_use=0 \
    ro.gps.agps_provider=1 \
    ro.qc.sdk.izat.premium_enabled=0 \
    ro.qc.sdk.izat.service_mask=0x0

# Graphics
PRODUCT_PROPERTY_OVERRIDES += \
    debug.egl.hw=1 \
    debug.mdpcomp.logs=0 \
    debug.sf.hw=1 \
    dev.pm.dyn_samplingrate=1 \
    persist.hwc.mdpcomp.enable=true \
    ro.sf.lcd_density=320 \
    ro.opengles.version=196608

# Input
PRODUCT_PROPERTY_OVERRIDES += \
    ro.input.noresample=1

# IO Scheduler
PRODUCT_PROPERTY_OVERRIDES += \
    sys.io.scheduler=bfq

# Time services
PRODUCT_PROPERTY_OVERRIDES += \
    persist.timed.enable=true

# Wifi
PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0
    
# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    qcom.bluetooth.soc=smd \
    ro.bluetooth.dun=true \
    ro.bluetooth.hfp.ver=1.6 \
    ro.bluetooth.sap=true \
    ro.qualcomm.bt.hci_transport=smd
    
# Camera
PRODUCT_PROPERTY_OVERRIDES += \
    media.stagefright.legacyencoder=true \
    media.stagefright.less-secure=true
    
#Set composition for USB
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=charged

#Set read only default composition for USB    
PRODUCT_PROPERTY_OVERRIDES += \
    ro.sys.usb.default.config=charged
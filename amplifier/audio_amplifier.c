/*
 * Copyright (C) 2013, The CyanogenMod Project / Nightcore
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "audio_amplifier"
//#define LOG_NDEBUG 0

#include <stdio.h>
#include <sys/ioctl.h>
#include <fcntl.h>

#include <cutils/log.h>

#include <hardware/audio_amplifier.h>

#include <msm8974/platform.h>

#include "tfa9887.h"
#include "rt5501.h"

#define UNUSED __attribute__((unused))

typedef struct memul_device {
    amplifier_device_t amp_dev;
    audio_mode_t current_mode;
} memul_device_t;

static memul_device_t *memul_dev = NULL;

static int amp_set_mode(amplifier_device_t *device, audio_mode_t mode)
{
    int ret = 0;
    memul_device_t *dev = (memul_device_t *) device;

    dev->current_mode = mode;

    return ret;
}

static int amp_set_output_devices(amplifier_device_t *device, uint32_t devices)
{
    memul_device_t *dev = (memul_device_t *) device;

    switch (devices) {
        case SND_DEVICE_OUT_HEADPHONES:
        case SND_DEVICE_OUT_VOICE_HEADPHONES:
        case SND_DEVICE_OUT_VOIP_HEADPHONES:
        case SND_DEVICE_OUT_SPEAKER_AND_HEADPHONES:
            rt55xx_set_mode(dev->current_mode);
            break;
    }
    return 0;
}

static int amp_enable_output_devices(amplifier_device_t *device,
        uint32_t devices, bool enable)
{
    memul_device_t *dev = (memul_device_t *) device;

    switch (devices) {
        case SND_DEVICE_OUT_SPEAKER:
        case SND_DEVICE_OUT_SPEAKER_REVERSE:
        case SND_DEVICE_OUT_VOICE_SPEAKER:
        case SND_DEVICE_OUT_SPEAKER_PROTECTED:
        case SND_DEVICE_OUT_VOIP_SPEAKER:
        case SND_DEVICE_OUT_SPEAKER_AND_HEADPHONES:
            tfa9887_power(enable);
            if (enable)
                /* FIXME: This may fail because I2S is not active */
                tfa9887_set_mode(dev->current_mode);
            break;
    }

    return 0;
}

static int amp_dev_close(hw_device_t *device)
{
    memul_device_t *dev = (memul_device_t *) device;

    tfa9887_power(false);
    tfa9887_close();

    free(dev);

    return 0;
}

static int amp_module_open(const hw_module_t *module, UNUSED const char *name,
        hw_device_t **device)
{
    if (memul_dev) {
        ALOGE("%s:%d: Unable to open second instance of TFA9887 amplifier\n",
                __func__, __LINE__);
        return -EBUSY;
    }

    memul_dev = calloc(1, sizeof(memul_device_t));
    if (!memul_dev) {
        ALOGE("%s:%d: Unable to allocate memory for amplifier device\n",
                __func__, __LINE__);
        return -ENOMEM;
    }

    memul_dev->amp_dev.common.tag = HARDWARE_DEVICE_TAG;
    memul_dev->amp_dev.common.module = (hw_module_t *) module;
    memul_dev->amp_dev.common.version = HARDWARE_DEVICE_API_VERSION(1, 0);
    memul_dev->amp_dev.common.close = amp_dev_close;

    memul_dev->amp_dev.set_input_devices = NULL;
    memul_dev->amp_dev.set_output_devices = amp_set_output_devices;
    memul_dev->amp_dev.enable_input_devices = NULL;
    memul_dev->amp_dev.enable_output_devices = amp_enable_output_devices;
    memul_dev->amp_dev.set_mode = amp_set_mode;
    memul_dev->amp_dev.output_stream_start = NULL;
    memul_dev->amp_dev.input_stream_start = NULL;
    memul_dev->amp_dev.output_stream_standby = NULL;
    memul_dev->amp_dev.input_stream_standby = NULL;

    memul_dev->current_mode = AUDIO_MODE_NORMAL;

    *device = (hw_device_t *) memul_dev;

    tfa9887_open();
    rt55xx_open();

    return 0;
}

static struct hw_module_methods_t hal_module_methods = {
    .open = amp_module_open,
};

amplifier_module_t HAL_MODULE_INFO_SYM = {
    .common = {
        .tag = HARDWARE_MODULE_TAG,
        .module_api_version = AMPLIFIER_MODULE_API_VERSION_0_1,
        .hal_api_version = HARDWARE_HAL_API_VERSION,
        .id = AMPLIFIER_HARDWARE_MODULE_ID,
        .name = "MEMUL audio amplifier HAL",
        .author = "The CyanogenMod Open Source Project",
        .methods = &hal_module_methods,
    },
};
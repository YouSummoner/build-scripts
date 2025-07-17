#!/usr/bin/env bash

# --- clean project-object cache to prevent hook mismatch loop ---
rm -rf .repo/local_manifests
rm -rf device/realme/RMX1921
rm -rf vendor/realme/RMX1921
rm -rf kernel/realme/sdm710
rm -rf prebuilts/clang/host/linux-x86
rm -rf build/soong/fsgen
# ───────────────────────── 1. Init & sync RisingOS ──────────────────────
repo init -u https://github.com/RisingOS-Revived/android -b qpr2 --git-lfs

# Let Crave's helper perform the heavy sync/repair work
/opt/crave/resync.sh

# ───────────────────────── 3. Clone device/vendor/kernel ────────────────
# (replace branches if needed)
git clone --depth=1 https://github.com/YouSummoner/device_realme_RMX1921 -b rising device/realme/RMX1921
git clone --depth=1 https://github.com/YouSummoner/vendor_realme_RMX1921 -b 15 vendor/realme/RMX1921
git clone --depth=1 https://github.com/YouSummoner/android_kernel_realme_sdm710 -b 14 kernel/realme/sdm710

# ───────────────────────── 4. Clone compiler ────────────────────────────
git clone --depth=1 https://github.com/kdrag0n/proton-clang prebuilts/clang/host/linux-x86/clang-proton

# ───────────────────────── 5. Apply dt2w patch ─────────────────────────

# ───────────────────────── 6. Build environment ────────────────────────
source build/envsetup.sh

# Build metadata (place *after* envsetup so Rising helper picks them up)
export BUILD_USERNAME="YouSummoner"
export BUILD_HOSTNAME="crave"
export TZ="Asia/Kolkata"

# Generate makefiles & lunch
lunch rising_RMX1921-userdebug

# ───────────────────────── 7. Clean + build ─────────────────────────────
rise b

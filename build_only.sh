# ───────────────────────── 1. Build environment ────────────────────────
source build/envsetup.sh

# Build metadata (place *after* envsetup so Rising helper picks them up)
export BUILD_USERNAME="YouSummoner"
export BUILD_HOSTNAME="crave"
export TZ="Asia/Kolkata"

# Generate makefiles & lunch
gk -f
lunch lineage_RMX1921-userdebug

# ───────────────────────── 2. Clean + build ─────────────────────────────
make installclean
rise sb

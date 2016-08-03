FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "git://github.com/OP-TEE/optee_os.git;branch=${BRANCH}"
SRCREV = "88885202c4ee01d44c6f51600100e5772975bf16"

SRC_URI += " \
    file://0001-Added-R-Car-H3-board-support.patch \
    file://0002-plat-rcar-add-missing-changes.patch \
"
PV = "2.0.0+renesas+git${SRCPV}"

export CROSS_COMPILE64="${CROSS_COMPILE}"

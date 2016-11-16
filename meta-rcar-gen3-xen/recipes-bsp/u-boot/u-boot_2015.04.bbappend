FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://0001-arm-renesas-Do-not-disable-MSTP3.patch \
    file://0002-arm-fdt-Don-t-touch-memory-node-from-full-U-Boot-in-.patch \
"

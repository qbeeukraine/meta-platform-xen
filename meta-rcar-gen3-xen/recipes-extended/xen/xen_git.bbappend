FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS += "u-boot-mkimage-native systemd"

PACKAGECONFIG ?= " \
    sdl \
    xsm \
    ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)} \
    ${@bb.utils.contains('XEN_TARGET_ARCH', 'x86_64', 'hvm', '', d)} \
    "

XEN_REL="4.7"
SRCREV = "c2a17869d5dcd845d646bf4db122cad73596a2be"

FLASK_POLICY_FILE="xenpolicy-4.7.0-rc"

SRC_URI += "\
    file://0001-arm64-renesas-Introduce-early-console-for-Salvator-X.patch \
    file://0002-char-scif-Add-Renesas-Salvator-X-board-support.patch \
    file://0003-HACK-Fix-compilation-issues.patch \
    file://0004-Enable-XSM.patch \
    file://0005-Hack.patch \
    file://0006-arm-passthrough-ignore-passthrough-PCI-devices.patch \
    file://0007-libxl-Add-passthrough-nodes-list.patch \
    file://0008-libxl-Add-comatible-list-to-config-file.patch \
    file://0009-flask-policy-introduce-driver-domain-label.patch \
    file://0010-xen-arm-allow-reassigning-of-hw-interrupts.patch \
    file://0011-xen-arm-allow-to-allocate-1-128-256-512-Mb.patch \
    file://0012-domctl-introduce-set_11_mapping.patch \
    file://0013-xen-arm-unlink-driver-domain-property-from-the-domai.patch \
    file://0014-xen-policy-allow-1-1-mapping-for-domD.patch \
    file://0015-xen-arm-alloc-domain-memory-1-to-1.patch \
    file://0016-tools-Introduce-ARM32_SEPAR_MEM_SPLIT-option.patch \
    file://0017-xen-arm-Add-SMC-call-function-that-is-compatible-wit.patch \
    file://0018-xen-arm-add-basic-support-for-OP-TEE.patch \
    file://0019-arm-optee-add-support-for-shared-memory-across-domai.patch \
    file://0020-arm-optee-disable-SHM-cache.patch \
    file://0021-arm-optee-add-RPC-and-session-tracking.patch \
    file://0022-arm64-optee-Enable-OPTEE-for-arm64.patch \
    file://0023-arm-Do-not-check-memory-bank-contiguity.patch \
"
EXTRA_OEMAKE += " CONFIG_HAS_SCIF=y debug=y CONFIG_EARLY_PRINTK=salvator CONFIG_QEMU_XEN=n ARM32_SEPAR_MEM_SPLIT=y"

PACKAGES += "\
    ${PN}-livepatch \
    "

RDEPENDS_${PN}-base += "\
    ${PN}-livepatch \
    "

FILES_${PN}-hypervisor += "\
    /usr/lib/debug/xen-syms-* \
    "

FILES_${PN}-scripts-block += " \
    ${sysconfdir}/xen/scripts/block-dummy \
    "

FILES_${PN}-scripts-network += " \
    ${sysconfdir}/xen/scripts/colo-proxy-setup \
    "

FILES_${PN}-livepatch += "\
    /usr/sbin/xen-livepatch \
    "

FILES_${PN}-staticdev += "\
    ${exec_prefix}/lib64/libxenstore.a \
    ${exec_prefix}/lib64/libxenvchan.a \
    "

FILES_${PN}-libxencall-dev = "${exec_prefix}/lib64/libxencall.so"

FILES_${PN}-efi = ""

RDEPENDS_${PN}-efi = " \
    bash \
    python \
    "

do_deploy_append () {
    if [ -f ${D}/boot/xen ]; then
        uboot-mkimage -A arm64 -C none -T kernel -a 0x78080000 -e 0x78080000 -n "XEN" -d ${D}/boot/xen ${DEPLOYDIR}/xen-${MACHINE}.uImage
    fi
}

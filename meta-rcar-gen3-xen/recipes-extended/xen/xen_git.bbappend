FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS += "u-boot-mkimage-native systemd"

PACKAGECONFIG ?= " \
    xsm \
    ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'systemd', '', d)} \
    "

XEN_REL="4.8"
SRCREV = "d4e202c39f0e464dfcec0e28f56725d516e190c6"

FLASK_POLICY_FILE="xenpolicy-4.8.0-rc"

LIC_FILES_CHKSUM="file://COPYING;md5=bbb4b1bdc2c3b6743da3c39d03249095"

SRC_URI = "\
    git://xenbits.xen.org/xen.git;branch=staging \
"

SRC_URI += "\
    file://0001-arm64-renesas-Introduce-early-console-for-Salvator-X.patch \
    file://0003-HACK-Fix-compilation-issues.patch \
    file://0004-Enable-XSM.patch \
    file://0005-xen-arm-Force-to-allocate-Dom0-only-in-low-memory.patch \
    file://0006-Do-no-trap-smc-instructions.patch \
"

EXTRA_OEMAKE += " CONFIG_HAS_SCIF=y CONFIG_DEBUG=y CONFIG_EARLY_PRINTK=salvator CONFIG_QEMU_XEN=n"

PACKAGES += "\
    ${PN}-livepatch \
    ${PN}-efi \
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

FILES_${PN}-efi = "\
    ${exec_prefix}/lib64 \
    ${exec_prefix}/lib64/xen* \
    "

RDEPENDS_${PN}-efi = " \
    bash \
    python \
    "

SYSTEMD_SERVICE_${PN}-xencommons = " \
    proc-xen.mount \
    var-lib-xenstored.mount \
    xen-qemu-dom0-disk-backend.service \
    xenconsoled.service \
    xen-init-dom0.service \
    xenstored.service \
    "

FILES_${PN}-devd += "\
    ${systemd_unitdir}/system/xendriverdomain.service \
    "

FILES_${PN}-scripts-common += "\
   ${sysconfdir}/xen/scripts/launch-xenstore \
   "

do_deploy_append () {
    if [ -f ${D}/boot/xen ]; then
        uboot-mkimage -A arm64 -C none -T kernel -a 0x78080000 -e 0x78080000 -n "XEN" -d ${D}/boot/xen ${DEPLOYDIR}/xen-${MACHINE}.uImage
    fi
}

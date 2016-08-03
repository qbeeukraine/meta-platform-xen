FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# aufs kernel support required for xen-image-minimal
KERNEL_FEATURES_append += "${@bb.utils.contains('DISTRO_FEATURES', 'aufs', ' features/aufs/aufs-enable.scc', '', d)}"

# kernel xen support and patches 
SRC_URI_append_salvator-x-xen-dom0 = " file://xen_dom0.scc"
SRC_URI_append_salvator-x-xen-domd = " file://xen_domd.scc"

SRC_URI_append_salvator-x-xen = " \
    file://defconfig \
"

#Add Xen to build
IMAGE_INSTALL_append = " \
    xen-base \
    xen-flask \
"

populate_append() {
	install -m 0644 ${DEPLOY_DIR_IMAGE}/xen-${MACHINE}.gz ${DEST}/xen.gz
}


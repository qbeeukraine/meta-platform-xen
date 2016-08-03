SRC_URI = "git://github.com/OP-TEE/optee_client.git;branch=${BRANCH}"
SRCREV = "2.0.0"

SRC_URI += " \
    file://optee.service \
"

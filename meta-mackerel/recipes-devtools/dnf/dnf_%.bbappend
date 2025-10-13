FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:qemuriscv64 = " file://0001-add-local-repo-config.patch"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

COMPATIBLE_MACHINE = "qemuriscv64"

SRC_URI:append:qemuriscv64 = " file://wired.network"

do_install:append:qemuriscv64() {
    # Overwrite the default DHCP wired.network with our static IP configuration
    install -m0644 ${S}/wired.network ${D}${systemd_unitdir}/network/80-wired.network
}

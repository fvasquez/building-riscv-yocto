# Building RISC-V Linux Images with Yocto

This is the Git repo for **Building RISC-V Linux Images with Yocto** taking place at the **RISC-V Developer Workshops North America** happening on Wednesday October 22, 2025. Attendees will use Yocto to build a custom 64-bit RISC-V Linux distro for the QEMU machine emulator. We will also boot and interact with our distro image on QEMU.

This hands-on in-person workshop requires Linux on your laptop or remote access to your own Linux workstation. If you are on macOS, create a Linux virtual machine using Parallels. If you are on Windows, install Ubuntu on WSL 2. Workshop participants should also come prepared with the following on their Linux machines:

- Docker or Podman installed and running
- qemu-system-riscv64 installed
- 20 GB or more of free space

Attendees are also strongly encouraged to download the following prebuilt artifacts beforehand in the event that storage space or download speeds becomes a problem.

- Prebuilt `qemuriscv64.tar.gz` image: https://github.com/fvasquez/building-riscv-yocto/releases/tag/v1.0
- Prepopulated `sstate-cache` parts 1 to 3: https://github.com/fvasquez/building-riscv-yocto/releases/tag/v1.1

The three `sstate-cache` parts consume 4 GB of storage space before extraction.

## Download prepopulated `sstate-cache`

Skip this step if you have already transferred all three `sstate-cache` parts to your Linux machine.

Download three `sstate-cache` parts to your Linux machine:

```
wget https://github.com/fvasquez/building-riscv-yocto/releases/download/v1.1/sstate-cache-part1.tar.gz &
wget https://github.com/fvasquez/building-riscv-yocto/releases/download/v1.1/sstate-cache-part2.tar.gz &
wget https://github.com/fvasquez/building-riscv-yocto/releases/download/v1.1/sstate-cache-part3.tar.gz
```

Check that all three downloads have completed:

```
$ jobs

```

Check size of downloaded parts:

```
$ ls -lh
total 4.0G
-rw-r--r-- 1 frank frank 1.8G Oct 13 12:46 sstate-cache-part1.tar.gz
-rw-r--r-- 1 frank frank 718M Oct 13 12:47 sstate-cache-part2.tar.gz
-rw-r--r-- 1 frank frank 1.6G Oct 13 12:48 sstate-cache-part3.tar.gz
```

## Extract prepopulated `sstate-cache`


Create Yocto work directory:

```
mkdir -p ~/yocto
```

Move all three `sstate-cache` parts to Yocto work directory:

```
mv sstate-cache-part*.tar.gz ~/yocto/.
```

Navigate to Yocto work directory:

```
cd ~/yocto
```

Extract parts to `~/yocto/sstate-cache` directory:

```
for part in sstate-cache-part*.tar.gz; do tar -xzf "$part"; done
```

Check size of prepopulated `sstate-cache` directory:

```
$ du -sh ~/yocto/sstate-cache
3.1G	/var/home/frank/yocto/sstate-cache
```

Delete archive files from Yocto work directory if storage space is a concern:

```
rm sstate-cache-part*.tar.gz
```

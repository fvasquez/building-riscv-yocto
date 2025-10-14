# Building RISC-V Linux Images with Yocto

This is the Git repo for **Building RISC-V Linux Images with Yocto** taking place at the **RISC-V Developer Workshops North America** happening on Wednesday October 22, 2025. Attendees will use Yocto to build a custom 64-bit RISC-V Linux distro for the QEMU machine emulator. We will also boot and interact with our distro image on QEMU.

This hands-on in-person workshop requires Linux on your laptop or remote access to your own Linux workstation. If you are on macOS, create a Linux virtual machine using Parallels. If you are on Windows, install Ubuntu on WSL 2. Workshop participants should also come prepared with the following on their Linux machines:

- `qemu-system-riscv64` installed
- Docker or Podman installed
- `kas-container` installed
- 20 GB or more available storage space

Attendees are also strongly encouraged to download the following prebuilt artifacts beforehand in the event that storage space or download speed becomes a problem.

- Prebuilt `qemuriscv64.tar.gz` image: https://github.com/fvasquez/building-riscv-yocto/releases/tag/v1.0
- Prepopulated `sstate-cache` parts 1 to 3: https://github.com/fvasquez/building-riscv-yocto/releases/tag/v1.1

The three `sstate-cache` parts consume 4 GB of storage space before extraction.

## Install `qemu-system-riscv64`

The installation method varies between Linux distros.

**Debian/Ubuntu:**
```
sudo apt update
sudo apt install qemu-system-misc
```

**Fedora/RHEL/CentOS:**
```
sudo dnf install qemu-system-riscv
```

Verify installation:
```
$ qemu-system-riscv64 --version
QEMU emulator version 9.1.3 (qemu-9.1.3-2.fc41)
Copyright (c) 2003-2024 Fabrice Bellard and the QEMU Project developers
```

Most modern Linux distros from the last 2 to 3 years include `qemu-system-riscv64` in their package repos, so there should be no need to build `qemu-system-riscv64` from source.

## Install Docker

Verify that Docker isn't already installed:
```
$ docker --version
Docker version 28.5.1, build e180ab8ab8
```

Verify that Podman isn't already installed:
```
$ podman --version
podman version 5.6.2
```

If either is installed on your Linux machine, then skip the rest of this step. If neither is installed, then I recommend installing Docker.

Here is the quickest way to get Docker up and running on Debian or Ubuntu. The installation method will be different for other Linux distros.

**Debian/Ubuntu:**
```
sudo apt install docker.io
```

Start Docker daemon and add yourself to `docker` group:
```
sudo systemctl start docker
sudo usermod -aG docker $USER
```

Log out and back in for group changes to take effect.

Verify installation:
```
$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
17eec7bbc9d7: Pull complete 
Digest: sha256:54e66cc1dd1fcb1c3c58bd8017914dbed8701e2d8c74d9262e26bd9cc1642d31
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
```

With Docker or Podman installed and running, you are almost ready to build Linux images with Yocto.

## Install `kas-container`

Create `~/bin` directory if it doesn't exist:
```
mkdir -p ~/bin
```

Download and install `kas-container` script:
```
wget -O ~/bin/kas-container https://raw.githubusercontent.com/siemens/kas/master/kas-container
```

Make `kas-container` script executable:
```
chmod +x ~/bin/kas-container
```

Add to `$HOME/bin` to the `PATH` environment variable in your `.bashrc` or `.profile` if not already present.

Log out and back in for `PATH` environment variable changes to take effect.

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

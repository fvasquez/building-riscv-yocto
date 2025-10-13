Download and extract prepopulated `sstate-cache` for *Building RISC-V Linux Images with Yocto* developer workshop on October 22.

Create and navigate to Yocto work directory:

```
mkdir -p ~/yocto
cd ~/yocto
```

Download three `sstate-cache` parts to `~/yocto` directory:

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

Extract parts to `~/yocto/sstate-cache` directory:

```
for part in sstate-cache-part*.tar.gz; do tar -xzf "$part"; done
```

Check size of prepopulated `sstate-cache` directory:

```
$ du -sh sstate-cache
3.1G    sstate-cache
```

Delete temp files:

```
rm sstate-cache-part*.tar.gz
rm wget-log*
```

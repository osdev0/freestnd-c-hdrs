#! /bin/sh

set -ex

for target_arch in i686 x86_64 aarch64 loongarch64 riscv64 m68k; do
    TARGET="${target_arch}-elf" ./make_toolchain.sh

    mkdir -p ${target_arch}
    rm -rf ${target_arch}/include
    mv toolchain/lib/gcc/${target_arch}-elf/*/include ${target_arch}/
    for f in patches/*; do
        ( cd ${target_arch} && patch -p0 <../$f )
    done
done

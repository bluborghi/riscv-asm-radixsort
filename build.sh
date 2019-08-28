riscv64-unknown-elf-as -g -o main.o main.s
riscv64-unknown-elf-as -g -o radixsort.o radixsort.s
riscv64-unknown-elf-ld -o radixsort radixsort.o main.o
rm -r radixsort.o
rm -r main.o
qemu-riscv64 -g 4444 radixsort

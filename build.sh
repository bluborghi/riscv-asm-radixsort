cd ./src
riscv64-unknown-elf-as -g -o main.o main.s
riscv64-unknown-elf-as -g -o radixsort.o radixsort.s
riscv64-unknown-elf-as -g -o countingsort.o countingsort.s
riscv64-unknown-elf-as -g -o arrayutils.o arrayutils.s
riscv64-unknown-elf-ld -o radixsort radixsort.o main.o countingsort.o arrayutils.o
rm -r radixsort.o
rm -r main.o
rm -r countingsort.o
rm -r arrayutils.o
mv radixsort ..
cd ..
qemu-riscv64 -g 4445 radixsort

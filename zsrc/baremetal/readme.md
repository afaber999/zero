tutorial from:
https://www.ringtailsoftware.co.uk/zig-baremetal/




sudo apt install qemu-utils qemu-system-riscv32 qemu-system-gui




zig build
//wc -c zig-out/bin/hello.bin
ri
scv64-unknown-elf-objdump -d -x -S zig-out/bin/hello


qemu-system-riscv32 -machine virt -nographic -bios hello.bin



## ESP32 IDF install
sudo apt-get install git wget flex bison gperf python3 python3-pip python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0
mkdir -p ~/esp
cd ~/esp
git clone -b v5.3 --recursive https://github.com/espressif/esp-idf.git

cd ~/esp/esp-idf
./install.sh esp32

## QEMU FOR ESP32

https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-guides/tools/qemu.html

sudo apt-get install -y libgcrypt20 libglib2.0-0 libpixman-1-0 libsdl2-2.0-0 libslirp0


build/qemu-system-riscv32 -nographic \
    -icount 3 \
    -machine esp32c3 \
    -drive file=flash_image.bin,if=mtd,format=raw

PROG        ?= firmware
ARCH        ?= esp32c3
SOURCES = main.c
ESPUTIL     ?= ../esputil/esputil
TOOLCHAIN   ?= riscv64-unknown-elf
LINKFLAGS   ?= -Tlink.ld -nostdlib -nostartfiles -Wl,--gc-sections $(EXTRA_LINKFLAGS)
NEWLIB?=/usr/include/newlib

CFLAGS      ?= -W -Wall -Wextra -Werror -Wshadow -pedantic \
               -Wdouble-promotion -fno-common  \
               -march=rv32imc -mabi=ilp32 \
               -Os -ffunction-sections -fdata-sections \
               -I. -I$(NEWLIB) $(EXTRA_CFLAGS)
SRCS        ?= boot.c $(SOURCES)


#riscv64-unknown-elf-gcc 
#-W -Wall -Wextra -Werror -Wshadow -pedantic \
#-Wdouble-promotion -fno-common  -march=rv32imc -mabi=ilp32 
#-Os -ffunction-sections -fdata-sections \
#-I. -I/home/albert/repos/esp32c3/mdk/esp32c3 -I/usr/include/newlib /home/albert/repos/esp32c3/mdk/esp32c3/boot.c main.c -T/home/albert/repos/esp32c3/mdk/esp32c3/link.ld -nostdlib -nostartfiles -Wl,--gc-sections  -o firmware.elf

build: $(PROG).bin


$(PROG).elf: $(SRCS)
	$(TOOLCHAIN)-gcc  $(CFLAGS) $(SRCS) $(LINKFLAGS) -o $@
#	$(TOOLCHAIN)-size $@


$(PROG).bin: $(PROG).elf $(ESPUTIL)
	$(ESPUTIL) mkbin $(PROG).elf $@


monitor: $(ESPUTIL)
	$(ESPUTIL) monitor


$(ESPUTIL): ../esputil/esputil.c
	make -C ../esputil esputil


clean:
	@rm -rf *.{bin,elf,map,lst,tgz,zip,hex} $(PROG)*

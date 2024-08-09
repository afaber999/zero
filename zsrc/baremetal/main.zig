const SYSCON_REG_ADDR: usize = 0x11100000;
const UART_BUF_REG_ADDR: usize = 0x10000000;

const syscon: *volatile u8 = @ptrFromInt(SYSCON_REG_ADDR);
const uart_buf_reg: *volatile u8 = @ptrFromInt(UART_BUF_REG_ADDR);

export fn _start() callconv(.Naked) noreturn {
    asm volatile ("la sp, _sstack"); // set stack pointer
    for ("Hello world\n") |b| {
        // write each byte to the UART FIFO
        uart_buf_reg.* = b;
    }

    while (true) {}
}

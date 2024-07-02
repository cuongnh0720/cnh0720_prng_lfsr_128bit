module lfsr_128bit (
    input wire i_clk,
    input wire i_reset,
    input wire [127:0] i_seed,
    output reg [127:0] o_lfsr,
    output reg o_keystream
);

reg [127:0] lfsr_reg;
reg msb_lfsr;
reg keystream_reg;

// Always block triggered on the rising edge of the clock or the reset signal
always @(posedge i_clk or posedge i_reset) begin
    if (i_reset) begin
        // Asynchronous reset: Initialize LFSR with seed value and other registers
        lfsr_reg <= i_seed;
        msb_lfsr <= 0;
        keystream_reg <= i_seed[0];
    end else begin
        // On the rising edge of the clock: Update LFSR and keystream registers
        msb_lfsr <= lfsr_reg[127] ^ lfsr_reg[6] ^ lfsr_reg[1] ^ lfsr_reg[0];
        keystream_reg <= lfsr_reg[0];
        lfsr_reg <= {msb_lfsr, lfsr_reg[127:1]};
    end
end

// Separate always block to drive outputs based on internal registers
always @(posedge i_clk) begin
    o_lfsr <= lfsr_reg;
    o_keystream <= keystream_reg;
end

endmodule

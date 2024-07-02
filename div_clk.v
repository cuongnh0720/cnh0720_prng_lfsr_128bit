module div_clk #(
    parameter integer n = 4
)(
    input wire i_clk,
    output reg o_clk
);

reg [31:0] d1hz_r = 1;
reg [31:0] d1hz_n;

always @(posedge i_clk) begin
    d1hz_r <= d1hz_n;
end

always @* begin
    if (d1hz_r == n) begin
        d1hz_n = 1;
    end else begin
        d1hz_n = d1hz_r + 1;
    end
end

always @(posedge i_clk) begin
    if (d1hz_r == n/2) begin
        o_clk <= 1;
    end else begin
        o_clk <= 0;
    end
end

endmodule

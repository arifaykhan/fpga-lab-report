module threecounter(
    input  wire clk,
    input  wire reset,
    input  wire enable,
    output wire [6:0] disp,
    output wire [5:0] dig
);

    wire [3:0] digit;        // normal BCD from counter
    wire [3:0] bcd_inv;      // inverted BCD for sevenseg

    counter bcd_counter (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .cnt(digit)
    );

    assign bcd_inv = ~digit;  // your decoder expects inverted BCD

    sevenseg display (
        .bcd(bcd_inv),
        .disp(disp),
        .dig(dig)
    );

endmodule
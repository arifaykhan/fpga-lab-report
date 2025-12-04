module threecounter(
    input  wire clk,
    input  wire reset,
    input  wire enable,
    output wire [6:0] disp,
    output wire [5:0] dig
);

    wire [3:0] digit;        
    wire [3:0] bcd_inv;      

    counter bcd_counter (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .cnt(digit)
    );

    assign bcd_inv = ~digit;  

    sevenseg display (
        .bcd(bcd_inv),
        .disp(disp),
        .dig(dig)
    );
endmodule

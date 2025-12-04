`timescale 1ns/1ps

module tb_counter;
reg clk;
reg reset;
reg enable;
wire [3:0] cnt;

counter dut(
    .clk(clk),
	 .reset(reset),
	 .enable(enable),
	 .cnt(cnt)
);

initial begin
    clk = 0;
	 forever #5 clk = ~clk;
end

initial begin
	 reset = 1;
	 enable = 1;
	 
	 #10 reset = 0;	
	 #20 reset = 1;
	 
	 #20 enable = 0;
	 #200 enable = 1;
	 
	 #30 reset = 0;
	 #20 reset = 1;
	 
	 #20 enable = 0;
	 #300 enable = 1;
	 
	 #200 $stop;
end

endmodule
	 
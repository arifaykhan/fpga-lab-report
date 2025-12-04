module counter(
    input wire clk,
	 input wire reset,
	 input wire enable,
	 output reg [3:0] cnt
);

reg [24:0] clk_prescaler = 0;
wire slow_clk = clk_prescaler[24];

always@(posedge clk) begin
    clk_prescaler <= clk_prescaler + 1;
end

always@(posedge slow_clk or negedge reset) begin
    if (!reset) begin
	 cnt <= 4'b0000;
	 end
    else if (!enable) begin
        if (cnt == 4'b1001) cnt <= 4'b0000;
	     else cnt <= cnt + 1;
    end
end 
endmodule
module sevenseg (
    input wire [3:0] bcd,
	 output reg [6:0] disp,
	 output reg [5:0] dig
);


always@(*) begin
     dig = 6'b011111;
     case(bcd)
        4'b1111: disp = 7'b1000000; //0
	     4'b1110: disp = 7'b1111001; //1
	     4'b1101: disp = 7'b0100100; //2 0100100
	     4'b1100: disp = 7'b0110000; //3 0110000
	     4'b1011: disp = 7'b0011001; //4 0011001
	     4'b1010: disp = 7'b0010010; //5 0010010
	     4'b1001: disp = 7'b0000010; //6 0000010
	     4'b1000: disp = 7'b1111000; //7 1111000
	     4'b0111: disp = 7'b0000000; //8
	     4'b0110: disp = 7'b0010000; //9 0011000
	     default: disp = 7'b1111111;
    endcase 
end

endmodule
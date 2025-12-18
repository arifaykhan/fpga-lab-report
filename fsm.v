module fsm(
    input wire clk,
    input wire reset,
    input wire x, 
    output wire led,
    output wire [6:0] disp,
    output wire [5:0] dig
);
    wire x_input_corrected;
    assign x_input_corrected = ~x; 
	 
    parameter DIV_LIMIT = 12500000; 
    reg [25:0] counter;
    reg slow_clk;

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            counter <= 0;
            slow_clk <= 0;
        end else begin
            if (counter >= DIV_LIMIT) begin
                counter <= 0;
                slow_clk <= ~slow_clk;
            end else begin
                counter <= counter + 1;
            end
        end
    end
    wire z_out_fsm;
    wire [3:0] state;

    fsmseq u_fsm (
        .clk(slow_clk),
        .reset_n(reset),
        .x(x_input_corrected),
        .z(z_out_fsm),
        .state_out(state)
    );
    assign led = z_out_fsm; 
	 
    sevenseg u_disp (
        .bcd(~state), 
        .disp(disp),
        .dig(dig)
    );
endmodule

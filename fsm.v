module fsm(
    input wire clk,           // 50MHz System Clock
    input wire reset,         // Reset Button (Active Low)
    input wire x,        // Serial Input Button (Active Low: 0=Press)
    output wire led,    // Match LED (Active Low: 0=ON)
    output wire [6:0] disp,// 7-segment segments
    output wire [5:0] dig// 7-segment digit select
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
        .clk(slow_clk),        // Slow clock
        .reset_n(reset),
        .x(x_input_corrected), // Use the inverted input
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
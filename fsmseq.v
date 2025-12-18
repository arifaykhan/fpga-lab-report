module fsmseq(
    input wire clk,
    input wire reset_n,
    input wire x,               
    output reg z,               
    output reg [3:0] state_out  
);
    
    parameter S0 = 3'b000; 
    parameter S1 = 3'b001; 
    parameter S2 = 3'b010; 
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    reg [2:0] state, next_state;
    
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        case (state)
            S0: next_state = (x) ? S1 : S0;
            S1: next_state = (x) ? S1 : S2;
            S2: next_state = (x) ? S3 : S0;
            S3: next_state = (x) ? S4 : S2;
            S4: begin
            next_state = (x) ? S1 : S0; 
            end
            default: next_state = S0;
        endcase
    end
    
    always @(*) begin
        z = (state == S4) ? 1'b1 : 1'b0;
        state_out = {1'b0, state};
    end
endmodule

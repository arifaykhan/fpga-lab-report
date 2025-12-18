module fsmseq (
    input wire clk,
    input wire reset_n,
    input wire x,               // Serial input
    output reg z,               // Output: 1 if match detected
    output reg [3:0] state_out  // Current state for display
);

    // State Encodings
    parameter S0 = 3'b000; // Reset
    parameter S1 = 3'b001; // Got '1'
    parameter S2 = 3'b010; // Got '10'
    parameter S3 = 3'b011; // Got '101'
    parameter S4 = 3'b100; // Got '1011' (Match)

    reg [2:0] state, next_state;

    // Sequential Block
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            state <= S0;
        else
            state <= next_state;
    end

    // Combinational Block (Next State)
    always @(*) begin
        next_state = state; // Default
        case (state)
            S0: next_state = (x) ? S1 : S0;
            S1: next_state = (x) ? S1 : S2;
            S2: next_state = (x) ? S3 : S0;
            S3: next_state = (x) ? S4 : S2;
            S4: begin
                // Non-overlapping: Search restarts. 
                // If x=1, it counts as the start of a NEW sequence (S1).
                next_state = (x) ? S1 : S0; 
            end
            default: next_state = S0;
        endcase
    end

    // Output Logic
    always @(*) begin
        z = (state == S4) ? 1'b1 : 1'b0;
        state_out = {1'b0, state}; // Zero-pad to 4 bits
    end

endmodule
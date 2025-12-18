`timescale 1ns / 1ps
module tb_fsmseq;

    reg clk;
    reg reset_n;
    reg x;

    wire z;
    wire [3:0] current_state;

    fsmseq uut (
        .clk(clk), 
        .reset_n(reset_n), 
        .x(x), 
        .z(z), 
        .state_out(current_state)
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    task apply_bit(input b);
        begin
            x = b;
            @(posedge clk);
            #2; // Small delay after edge for waveform clarity
        end
    endtask

    initial begin
        // --- Initialization ---
        reset_n = 0;
        x = 0;
        #40;
        reset_n = 1;
        #20;

        // --- Test 1: No Matches (11001) ---
        // Lab Requirement: Bitstream with no matches [cite: 10]
        apply_bit(1); // S1
        apply_bit(1); // Stay S1
        apply_bit(0); // S2
        apply_bit(0); // S0
        apply_bit(1); // S1
        #40;

        // --- Test 2: One Match (1011) ---
        // Lab Requirement: Bitstream with one match [cite: 11]
        apply_bit(1); // S1
        apply_bit(0); // S2
        apply_bit(1); // S3
        apply_bit(1); // S4 -> z should go HIGH here
        #20;          // z should go LOW on next clock (single cycle pulse) [cite: 13]

        apply_bit(1); // S1
        apply_bit(0); // S2
        apply_bit(1); // S3
        apply_bit(1); // S4 (Match Pulse)
        
        // Match 2 (Non-overlapping)
        apply_bit(1); // S1 (Fresh start, not reusing the last '1' for overlapping logic)
        apply_bit(0); // S2
        apply_bit(1); // S3
        apply_bit(1); // S4 (Match Pulse)
        
        #100;
        $stop;
    end

endmodule
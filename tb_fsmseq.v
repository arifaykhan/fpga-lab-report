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
            #2; 
        end
    endtask

    initial begin
        reset_n = 0;
        x = 0;
        #40;
        
        reset_n = 1;
        #20;
        
        apply_bit(1); 
        apply_bit(1); 
        apply_bit(0); 
        apply_bit(0); 
        apply_bit(1); 
        #40;

        apply_bit(1); 
        apply_bit(0); 
        apply_bit(1); 
        apply_bit(1); 
        #20;          

        apply_bit(1); 
        apply_bit(0); 
        apply_bit(1); 
        apply_bit(1); 
        apply_bit(1); 
        apply_bit(0); 
        apply_bit(1); 
        apply_bit(1);         
        #100;
        
        $stop;
    end
endmodule

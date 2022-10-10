/*
 * EE469 Autumn 2022
 * Haosen Li, Peter Tran
 * 
 * This file contains d_ff, a d flip-flop module.
 *
 * Inputs:
 * clk - A clock signal.
 * reset - A reset signal.
 * d - An input signal.
 * 
 * Outputs:
 * q - The output signal.
 */

module d_ff (
        input logic clk, reset, d,
        output logic q
    );
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule
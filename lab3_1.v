`timescale 1ns / 1ps

module ab(input A, input B, input clk, output reg Q);

    initial Q = 0;

    initial begin 
      Q = 0;
    end
	always @(posedge clk)
  begin
	if( A == 1'b0 && B == 1'b0)begin
		Q =Q; 
		end
	else if( A == 1'b0 && B == 1'b1) begin
		Q =1'b1;
		end
	else if( A == 1'b1 && B == 1'b0)begin
		Q =1'b0;
		end
	else if( A == 1'b1 && B == 1'b1)begin
		Q =~Q;
		end
   end
endmodule

module ic1337(// Inputs
              input I0,
              input I1,
              input I2,
              input clk,
              // Outputs
              output Q0,
              output Q1,
              output Z);

    ab uut (
      .A((~(I0|~I1))&(~I2)), 
      .B(I2), 
		.clk(clk),
		.Q(Q0)
	);
	ab uut1 (
      .A(~I2), 
      .B(~(~(~I1|I2)^I0)), 
		.clk(clk),
		.Q(Q1)
	);
	assign Z=Q0^Q1;

endmodule
`timescale 1ns / 1ps

module tb_control;

	// Inputs
	reg clk;
	reg nrst;
	reg send;

	// Outputs
	wire shift_en;
	wire done;
	wire load;
	wire ss;
	wire clk_en;

	// Instantiate the Unit Under Test (UUT)
	control uut (
		.clk(clk), 
		.nrst(nrst), 
		.send(send), 
		.shift_en(shift_en), 
		.done(done), 
		.load(load), 
		.ss(ss), 
		.clk_en(clk_en)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		nrst = 0;
		send = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule


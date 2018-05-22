`timescale 1ns / 1ps

module tb_rategen;

	// Inputs
	reg clk;
	reg nrst;
	reg en;

	// Outputs
	wire clk_out;
	wire sampling;
	wire update;

	// Instantiate the Unit Under Test (UUT)
	rategen uut (
		.clk(clk), 
		.nrst(nrst), 
		.en(en), 
		.clk_out(clk_out),
		.sampling(sampling),
		.update(update)
	);

	initial
	begin
		// Initialize Inputs
		clk = 0;
		nrst = 1;
		en = 0;

		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here
		#100 nrst <= 0;
		#100 nrst <= 1;
	end
	
	initial
	begin
		#950 en<= 1;
		#6000 en <= 0;
	end
	
	//10MHz frequency
	always #50
		clk <= ~clk;

endmodule

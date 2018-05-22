`timescale 1ns / 1ps

module tb_shiftreg16_out;

	// Inputs
	reg clk;
	reg nrst;
	reg load;
	reg [15:0] din;
	reg en;

	// Outputs
	wire dout;
	wire clk_out;
	
	//InOut
	wire sampling;
	wire update;

	// Instantiate the Unit Under Test (UUT)
	rategen uut2 (
		.clk(clk), 
		.nrst(nrst), 
		.en(en), 
		.clk_out(clk_out),
		.sampling(sampling),
		.update(update)
	);
	
	shiftreg16_out uut1 (
		.clk(clk), 
		.nrst(nrst), 
		.update(update), 
		.load(load), 
		.din(din), 
		.dout(dout)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		nrst = 1;
		load = 0;
		din = 0;
		en = 0;

		// Wait 50 ns for global reset to finish
		#50;        
		// Add stimulus here
		#100 nrst = 0;
		#100 nrst = 1;
		#300 load = 1; din = 0'haa33;
		#100 load = 0; din = 0;
	end

	initial
	begin
		#1050 en = 1;
		#25600 en = 0;
	end

	//10MHz frequency
	always #50
		clk <= ~clk;

      
endmodule


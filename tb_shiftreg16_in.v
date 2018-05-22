`timescale 1ns / 1ps

module tb_shiftreg16_in;

	// Inputs
	reg clk;
	reg nrst;
	reg sdin;
	reg en;
	
	// Outputs
	wire [15:0] dout;
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
	
	shiftreg16_in uut1 (
		.clk(clk), 
		.nrst(nrst), 
		.sampling(sampling), 
		.sdin(sdin),
		.dout(dout)
	);
	
	initial
	begin
		// Initialize Inputs
		clk = 0;
		nrst = 1;
		sdin = 0;
		en = 0;

		// Wait 100 ns for global reset to finish
		#100;
		// Add stimulus here
		#100 nrst <= 0;
		#100 nrst <= 1;
		#2250 en <= 1;
		#9000 en <= 0;
	end
	
	initial
	begin
		#2550 sdin <= 1;
		#1600 sdin <= 0;
		#3200 sdin <= 1;
		#3200 sdin <= 0;
	end
	
	
	//10MHz frequency
	always #50
		clk <= ~clk;
      
endmodule


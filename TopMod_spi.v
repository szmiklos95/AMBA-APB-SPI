`timescale 1ns / 1ps

module TopMod_spi(
	input clk, nrst, send,
	input  [15:0] data_in,
	output [15:0] data_out,
	output done,
	input  MISO,
	output MOSI, SCLK, SS
    );
	 
wire shift_en, clk_out, load, sampling, update;
	 
	rategen rate_generator (
		.clk(clk), 
		.nrst(nrst), 
		.en(shift_en), 
		.clk_out(SCLK),
		.sampling(sampling),
		.update(update)
	);
	
	shiftreg16_in shiftregister16_in (
		.clk(clk), 
		.nrst(nrst), 
		.sampling(sampling), 
		.sdin(MISO),
		.dout(data_out)
	);
	
	shiftreg16_out shiftregister16_out (
		.clk(clk), 
		.nrst(nrst), 
		.update(update), 
		.load(load), 
		.din(data_in), 
		.dout(MOSI)
	);
	
	control spi_control (
		.clk(clk), 
		.nrst(nrst), 
		.send(send),
		.sampling(sampling),
		.shift_en(shift_en), 
		.done(done), 
		.load(load), 
		.ss(SS)
	);

endmodule

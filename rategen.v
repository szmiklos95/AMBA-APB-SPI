`timescale 1ns / 1ps

// clock divider (16MHz -> 1MHz)

module rategen(
    input clk,
    input nrst,
	 input en,
    output clk_out,
	 output sampling,
	 output update
);
 
reg [3:0] cntr;

	always @ (posedge clk)
	begin
		if(!nrst)
			cntr <= 15;
		else if(en)
			cntr <= cntr + 1;
		else
			cntr <= cntr;	
	end

	assign clk_out = cntr[3];
	assign sampling = (en & (cntr==7));
	assign update = (en & (cntr==15));

endmodule

`timescale 1ns / 1ps

module shiftreg16_out(
    input clk, nrst, update, load,
	 input [15:0] din,
    output dout
);

reg [15:0] data;

	always @ (posedge clk)
	begin
		if(!nrst)
			data <= 0;
		else if(load)
			data <= {din[0],din[15:1]};
		else if(update)
			data <= {data[14:0], data[15]};
		else
			data <= data;
	end

	assign dout = data[15];

endmodule

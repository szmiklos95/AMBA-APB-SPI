`timescale 1ns / 1ps

module shiftreg16_in(
    input clk, nrst, sampling, sdin,
    output [15:0] dout
);

reg [15:0] data;

	always @ (posedge clk)
	begin
		if(!nrst)
			data <= 0;
		else if(sampling)
			data <= {data[14:0], sdin};
		else
			data <= data;
	end

	assign dout = data;

endmodule

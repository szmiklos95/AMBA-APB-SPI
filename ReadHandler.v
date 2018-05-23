`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:55:34 05/23/2018 
// Design Name: 
// Module Name:    ReadHandler 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ReadHandler(
		input PCLK, PRESETn,
		input IO_reg,
		input PWRITE,
		input PSEL, PENABLE,
		output [15:0] PRDATA,
		output PREADY_R,
		input [15:0] APB_data_in,
		input SPI_done
    );

reg reg_PREADY_R;
reg [15:0] reg_PRDATA;

always @(posedge PCLK)
begin

	//Reset
	if(PRESETn == 0) begin
		reg_PREADY_R <= 0;
		reg_PRDATA <= 0;
	end
	
	else begin
	
		if(IO_reg == 0 && PWRITE == 0 && PSEL == 1 && SPI_done == 1) begin
			
			if(PENABLE == 1) begin
				reg_PRDATA <= APB_data_in; //T2 phase
				reg_PREADY_R <= 1;
			end
			
		end
		
		else begin
			reg_PREADY_R <= 0;
		end
		
	end
	
end

assign PREADY_R = reg_PREADY_R;
assign PRDATA = reg_PRDATA;

endmodule

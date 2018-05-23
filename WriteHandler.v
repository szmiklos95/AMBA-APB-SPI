`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:29:00 05/23/2018 
// Design Name: 
// Module Name:    WriteHandler 
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
module WriteHandler(
		input PCLK, PRESETn,
		input IO_reg,
		input PWRITE,
		input PSEL, PENABLE,
		input [15:0] PWDATA,
		output PREADY_W,
		output [15:0] APB_data_out,
		output SPI_send
    );
	 
reg reg_PREADY_W, reg_SPI_send;
reg [15:0] reg_APB_data_out;

always @(posedge PCLK)
begin

	//Reset
	if(PRESETn == 0) begin
		reg_PREADY_W <= 0;
		reg_SPI_send <= 0;
		reg_APB_data_out <= 0;	
	end
	
	else begin
	
		if(IO_reg == 1 && PWRITE == 1 && PSEL == 1) begin
			reg_SPI_send <= 1; //First set this to one - T1 phase
			
			if(PENABLE == 1) begin
				reg_APB_data_out <= PWDATA; //T2 phase
				reg_PREADY_W <= 1;
			end
			
		end
		
		else begin
			reg_SPI_send <= 0;
			reg_PREADY_W <= 0;
		end
		
	end
	
end

assign PREADY_W = reg_PREADY_W;
assign SPI_send = reg_SPI_send;
assign APB_data_out = reg_APB_data_out;

endmodule

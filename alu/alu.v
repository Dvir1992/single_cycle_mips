/*
//////////////////////////////////////////////////////////////////////
Module name:            ALU
Description:             carries out basic arithmetic and logic operations, and the control section determines the operation.
//////////////////////////////////////////////////////////////////////
*/
module alu(
  reset,
  data1,
  data2,
  op,
  result,
  zero
);
  input reset;
  input [31:0] data1;
  input [31:0] data2;
  input [2:0] op;
  output reg [31:0] result;
  output reg zero;
  // Dealing with carry out is not relevant. Even if there is a carryout there is no room for our bass to accommodate it and the verilog will give the result without the carryout bit.
  
  always@(*) begin
	if(reset)
		result<=0;
	else begin		
     #2;
	 case (op)
	
		3'b000: result= data1 & data2;///and
		3'b001: result= data1 | data2;//or
		3'b010: result= data1 + data2;//lw, sw,add
		3'b110: result= data1 - data2;//sub
		3'b111: result= data1 << data2;//slt, beq
		default: result= 0;
		
	 endcase
	end
	zero=(result==0)?1:0;
	
  
  end
  
  
 
endmodule

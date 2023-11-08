/*
//////////////////////////////////////////////////////////////////////
Module name:            controller
Description:       responsible for setting all the control signals so that each instruction is executed properly.      
//////////////////////////////////////////////////////////////////////
*/
module ctrl(
  reset,
  op,
  funct,
  zero,
  aluop,
  reg_write,
  regdst,
  alusrc,
  memwrite,
  memread,
  memtoreg,
  pcsrc
  

);
  input reset;
  input [5:0] op;
  input [5:0] funct;
  input zero;
  output reg[2:0] aluop;
  output reg reg_write;
  output reg regdst;
  output reg alusrc;
  output reg memwrite;
  output reg memread;
  output reg memtoreg;
  output reg pcsrc;
  
  
  
  always@* begin
	if (reset)begin
		reg_write=0;
		aluop=0;
		regdst=0;
        alusrc=0;
        memwrite=0;
        memread=0;
        memtoreg=0;
        pcsrc=0;
	end
	else begin	
		case (op)
	
			6'b000000: begin
						case(funct)
						
							6'd33: aluop=010;
							6'd34: aluop=110;
							6'd36: aluop=000;
							6'd37: aluop=001;
							6'd42: aluop=111;
							default: aluop=010;
					
						endcase
						reg_write=1;
						regdst=1;
						alusrc=0;
						memwrite=0;
						memread=0;
						memtoreg=0;
						pcsrc=0;
						
					  end
			6'b100011: begin 
						aluop=010;
						reg_write=1;
						regdst=0;
						alusrc=1;
						memwrite=0;
						memread=1;
						memtoreg=1;
						pcsrc=0;
					   end
			6'b101011: begin
						aluop=010;
						reg_write=0;
						regdst=0;
						alusrc=1;
						memwrite=1;
						memread=0;
						memtoreg=0;
						pcsrc=0;
					   end
			6'b000100: begin
						aluop=110;
						reg_write=0;
						regdst=0;
						alusrc=0;
						memwrite=0;
						memread=0;
						memtoreg=0;
						pcsrc=((op==4)&&(zero));
					   end

			
	    endcase
	end
  
  end
  

 
endmodule




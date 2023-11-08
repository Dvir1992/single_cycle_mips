module tb_ctrl;
  reg reset;
  reg [5:0] op;
  reg [5:0] funct;
  reg zero;
  wire [2:0] aluop;
  wire reg_write;
  wire regdst;
  wire alusrc;
  wire memwrite;
  wire memread;
  wire memtoreg;
  wire pcsrc;
  
  
  
 ctrl c(
	.reset(reset),
	.op(op),
	.funct(funct),
	.zero(zero),
	.aluop(aluop),
	.reg_write(reg_write),
	.regdst(regdst),
	.alusrc(alusrc),
	.memwrite(memwrite),
	.memread(memread),
	.memtoreg(memtoreg),
	.pcsrc(pcsrc)
	);
  
 

   initial begin
	reset=1;
	op=0;
	zero=0;
	funct=0;
	#50;
	reset=0;
	
    op=0;//checking the r_type instructions.
	
	funct=33;
	#1;
	if(aluop==3'b010)
		$display("succsess");
	else
		$error("%t:failure",$time);
	#5;
	
	
	funct=34;
	#1;
	if(aluop==3'b110)
		$display("succsess");
	else
		$error("%t:failure",$time);
	#5;
	
	funct=36;
	#1;
	if(aluop==3'b000)
		$display("succsess");
	else
		$error("%t:failure",$time);
	#5;
	
	funct=37;
	#1;
	if(aluop==3'b001)
		$display("succsess");
	else
		$error("%t:failure",$time);
	#5;
	
	funct=42;
	#1;
	if(aluop==3'b111)
		$display("succsess");
	else
		$error("%t:failure",$time);
	#5;
	if ({reg_write,regdst,alusrc,memwrite,memread,memtoreg,pcsrc}==7'b1100000)
		$display("succsess");
	else
		$error("%t:failure",$time);
		
	#5;
	
	op=35;//checking lw
	#1
	if(aluop==3'b010)
		$display("succsess");
	else
		$error("%t:failure",$time);
	if ({reg_write,regdst,alusrc,memwrite,memread,memtoreg,pcsrc}==7'b1110110)
		$display("succsess");
	else
		$error("%t:failure",$time);
		
	#5;
	
	op=43;//checking sw
	#1;
	if(aluop==3'b010)
		$display("succsess");
	else
		$error("%t:failure",$time);
	if ({reg_write,regdst,alusrc,memwrite,memread,memtoreg,pcsrc}==7'b0011000)
		$display("succsess");
	else
		$error("%t:failure",$time);
		
	op=4;//checking branch
	zero=1;
	#1;
	if(aluop==3'b110)
		$display("succsess");
	else
		$error("%t:failure",$time);
	if ({reg_write,regdst,alusrc,memwrite,memread,memtoreg,pcsrc}==7'b0000001)
		$display("succsess");
	else
		$error("%t:failure",$time);
	
	
	
	
		
	#10;	
    $finish;
   end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  

    
  
      
endmodule


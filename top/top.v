/*
//////////////////////////////////////////////////////////////////////
Module name:            top
Description:       responsible for setting all the control signals so that each instruction is executed properly.      
//////////////////////////////////////////////////////////////////////
*/
module top(clk,reset);
    input clk;
	input reset;
	
	
    //instruction_memory o&i
	reg [31:0] pc;
	wire [31:0] inst_out;
	//rf o&i
	wire [5:0] write_reg;
	wire [31:0] write_data_rf;
	wire [31:0] read_data2;
	//ctrl o&i
	wire [2:0] aluop;
	wire reg_write;
	wire regdst;
	wire alusrc;
	wire memwrite;
	wire memread;
	wire memtoreg;
	wire pcsrc;
	//alu o&i
	wire [31:0] data1;
	wire [31:0] data2;
    wire [31:0] result;
	wire zero;
	//dm
	wire [31:0]read_data_dm;
	//top wires
	wire [31:0] sign_extend_out;
	
	
	
	instruction_memory i_m(
	.reset(reset),
	.read_adr(pc),
	.inst_out(inst_out)
	);
	
	register_file r_f(
	.clk(clk),
	.reset(reset),
	.read_reg1(inst_out[25:21]),
	.read_reg2(inst_out[20:16]),
	.write_reg(write_reg),
	.write_data(write_data_rf),
	.reg_write(reg_write),
	.read_data1(data1),
	.read_data2(read_data2)
	);
	
   alu a(
     .reset(reset),
     .data1(data1),
	 .data2(data2),
	 .op(aluop),
	 .result(result),
	 .zero(zero)
   );
   
   data_memory d(
	 .clk(clk),
     .reset(reset),
     .read_adr(result),
	 .write_adr(result),
	 .write_data(read_data2),
	 .memwrite(memwrite),
	 .memread(memread),
	 .read_data(read_data_dm)
   );
   
   ctrl c(
    .reset(reset),
	.op(inst_out[31:26]),
	.funct(inst_out[5:0]),
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
   
	
	
	
	
		
	
	always@(posedge clk or posedge reset) begin
		if (reset)
		     pc<=0;
		else 
			 #2 pc<=pcsrc?(pc+4+(sign_extend_out<<2)):(pc+4);//create 2 nano sec delay for the instructor adder
	end
	//rf
	assign write_reg= regdst? inst_out[15:11]:inst_out[20:16];
	assign write_data_rf=memtoreg?read_data_dm:result;
	//alu
	assign data2=alusrc? sign_extend_out:read_data2;
    //top
	assign sign_extend_out=$signed(inst_out[15:0]);

	

	
    


 
endmodule


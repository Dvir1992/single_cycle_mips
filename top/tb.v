module tb;
  reg reset;
  reg clk;
  reg [31:0] pc_before;
  
  
  
  top t(.clk(clk),.reset(reset));
  

   initial begin
    clk=0;
	reset=1;
	#50;
	@(posedge clk);
	reset=0;	
	//check sign_extend_out assignment
		force t.inst_out=16'b1111111111111111;
		#1;// we have to put this because there is another opreation before that must finish before the next one.
		if(t.sign_extend_out==32'hFFFFFFFF)
			$display("succsess");
		else
			$error("%t:failure",$time);
	@(posedge clk);
		force t.inst_out=16'b0111111111111111;
		#1;
		if(t.sign_extend_out==32'h00007FFF)
			$display("succsess");
		else
			$error("%t:failure",$time);
		release t.inst_out;
		
	//check pc calculation
		force t.pcsrc=0;
		force t.pc=4;
		release t.pc;
		force t.inst_out=4;
		@(posedge clk);
		if(t.pc==8)
			$display("succsess");
		else 
			$error("%t:failure",$time);
		force t.pcsrc=1;
		force t.pc=4;
		release t.pc;
		force t.inst_out=4;
		@(posedge clk);
		if(t.pc==24)
			$display("succsess");
		else 
			$error("%t:failure",$time);
		release t.pcsrc;
		release t.pc;
		release t.inst_out;
		reset=1;
		#50;
		@(posedge clk);
		reset=0;
		
	//check instructions are operating as needed:
	// we will use regiters 8(data=8),9(data=9),10(data=10),0(data=0),3(data=3),4(data=4),5(data=5)
	//the instructions:
		//0: '8'<-- '10'+'9'
		//1: '0'<-- '10'-'9'
		//2: '0'<-- '10' and '9'
		//3: '0'<-- '10' or '9'
		//4: '0'<-- '10' slt '9'
		//5: '3'<-- 4('0')
		//6: '3'--> 8('0')
		//7: beq '4' '5'
		//8: beq '5' '5'
		
		
	
		//for instruction 0-4, we used registers 10(data=10) and 9(data=9) for reading, 8 for writing. 
		//we expect to see the right data inisde register 8 at the start of the next clock.
		
			//0: R-type-add
				@(t.inst_out);
				@(posedge clk);
				#1;
				if(t.r_f.regs[8]==(10+9))
					$display("succsess");
				else 
					$error("%t:failure",$time);
			//1: R-type-sub
				@(t.inst_out);
				@(posedge clk);
				#1;
				if(t.r_f.regs[8]==(10-9))
					$display("succsess");
				else 
					$error("%t:failure",$time);
			//2: R-type-and
				@(t.inst_out);
				@(posedge clk);
				#1;
				if(t.r_f.regs[8]==(10&9))
					$display("succsess");
				else 
					$error("%t:failure",$time);
			//1: R-type-or
				@(t.inst_out);
				@(posedge clk);
				#1;
				if(t.r_f.regs[8]==(10|9))
					$display("succsess");
				else 
					$error("%t:failure",$time);
			//1: R-type-slt
				@(t.inst_out);
				@(posedge clk);
				#1;
				if(t.r_f.regs[8]==(10<<9))
					$display("succsess");
				else 
					$error("%t:failure",$time);
					
		//for instruction 5, we used registers 0(data=0) and sign_extend_out value to read the adding result of these and write them into register 3.
			//5:L-type_lw	
				@(t.inst_out);
				@(posedge clk);
				#1;
				if(t.r_f.regs[3]==(t.sign_extend_out+t.r_f.read_data1))
					$display("succsess");
				else 
					$error("%t:failure",$time);
		
		//for instruction 6, we read register 3(data=4) to write its data at the adding result of registe 0 (data=0) and sign_extend_out value.		
			//6:L-type_sw
			    @(t.inst_out);
				@(posedge clk);
				#1;
				if(t.d.mem[t.r_f.regs[0]+t.sign_extend_out]==t.r_f.regs[3])
					$display("succsess");
				else 
					$error("%t:failure",$time);
					
		//for instruction 7-8, we read the offset and check if two registers data is equal 
			//7:L-type_beq_not('4'=='5'):
			    @(t.inst_out);
				pc_before=t.pc;
				@(posedge clk);
				#3;
				if(t.pc==pc_before+4)
					$display("succsess");
				else 
					$error("%t:failure",$time);
					
			//8:L-type_beq('5'=='5'):
			    @(t.inst_out);
				pc_before=t.pc;
				@(posedge clk);
				#3;
				if(t.pc==pc_before+4+(t.sign_extend_out<<2))
					$display("succsess");
				else 
					$error("%t:failure",$time);
		
	
	#150;	
    $finish;
   end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  

  always#7 clk=~clk;

    
  
      
endmodule



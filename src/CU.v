module CU(Enter,Clock,Reset,Aeq0,Apos,IR158,IRload,JMPmux,PCload,RegWr,out,
Meminst,MemWr,Asel0,Aload,Sub,Halt,sel01,Asel1,Jsel ); 
input Enter,Clock,Reset,Aeq0,Apos; 
input [7:0] IR158; 
output reg IRload,JMPmux,PCload,Meminst,MemWr,Aload,Sub,Halt,RegWr,sel01; 
output reg[2:0] Asel0,Asel1;  // 3bits
output reg [1:0]  Jsel;
output reg out;
  // 信号是Halt , 状�?�HALT
//定义状�?�编�? 
parameter [4:0] START=5'b00000, FETCH=5'b00001, 
DECODE=5'b11100, LDA=5'b00010,STA=5'b00011,LDM =5'b00100,
STM =5'b00101,LDI =5'b00110,JMP=5'b00111,JZ=5'b01000,JNZ=5'b01001,
JP=5'b01010,AND=5'b01011,OR=5'b01100,
ADD = 5'b01101,SUB=5'b01110,NOT=5'b01111,INC =5'b10000,
DEC  =5'b10001,SHFL = 5'b10010,SHFR=5'b10011,ROTR=5'b10100,
 In=5'b10101,OUT=5'b10110,  HALT=5'b11111,NOP =5'b11110; 
 //input 是关键字不能�?,�?以要用inputt或In
reg [4:0] current_state, next_state; 
reg Rjudge;


//采用同步时序描述状�?�转�? 
always @(posedge Clock or posedge Reset) 
if(Reset) current_state<=START; 
else 
current_state<=next_state; 
 
//采用组合逻辑判断状�?�转移条件，描述状�?�转移规�? 
always @(current_state or IR158 or Enter) 
begin
case(current_state)     
START: next_state=FETCH;     
FETCH: next_state=DECODE;  	//00->01->1c
DECODE:      begin //仿真LDA-> LDI前五�? 
Rjudge=(IR158[3:0]==0);		  	 	 
					case(IR158[7:4])
				    4'b0000:next_state<=NOP;
				    4'b0001:next_state<=LDA;
					4'b0010:next_state<=STA;
					4'b0011:next_state<=LDM;
					4'b0100:next_state<=STM;
					4'b0101:next_state<=LDI;
					4'b0110:next_state<=JMP;
					4'b0111:next_state<=JZ;
					4'b1000:next_state<=JNZ;
					4'b1001:next_state<=JP;
					4'b1010:next_state<=AND;
					4'b1011:next_state<=OR;
					4'b1100:next_state<=ADD;
					4'b1101:next_state<=SUB;
					4'b1110:begin 
								case(IR158[3:0]) 
								4'b0000: next_state<=NOT;
								4'b0001: next_state<=INC;
								4'b0010: next_state<=DEC;
								4'b0011: next_state<=SHFL;
								4'b0100: next_state<=SHFR;
								4'b0101: next_state<=ROTR;
								default:next_state<=START;
								endcase
							end
					4'b1111:begin 
								case(IR158[3:0]) 
								4'b0000: next_state<=In;
								4'b0001: next_state<=OUT;
								4'b0010: next_state<=HALT;
								default:next_state<=START;
								endcase
							end
				    endcase
				   end
		HALT:next_state<=HALT;
		default:next_state<=START;
		endcase
end 
 
//使用同步时序电路描述每个状�?�的输出 
always 	@(posedge Clock or posedge Reset) 
begin 
IRload=0;Aload=0;PCload=0;sel01=0;MemWr=0;RegWr=0;
		Asel0=0;Asel1=0;Jsel=0;Halt=0;out = 0;
//为了�?洁，在开头将�?有信号初始化�?0，这样可省略START状�?�，且在每个状�?�中只需对不�?0的信号赋�?
if (Reset) 
   begin  
 	 IRload<=0; JMPmux<=0; PCload<=0; Meminst<=0; MemWr<=0; Asel0<=0;  
 	 Aload<=1;  Halt<=0; end 
else  
 begin   

case(next_state)   
	
    START: begin 
       PCload<=0; IRload<=0; JMPmux<=0; Meminst<=0; MemWr<=0; Asel0<=0;  

 	   Aload<=1;  Halt<=0;  
        end 

    FETCH: begin 
 	    PCload<=1;Meminst<=0; IRload<=1; JMPmux<=0;  MemWr<=0; Asel0<=0; 
 	    Aload<=1;  Halt<=0;  	   
        end 

    DECODE: begin 
 	     PCload<=0; IRload<=0; JMPmux<=0; Meminst<=1; MemWr<=0;  
 	     Asel0<=0; Aload<=1;  Halt<=0; 
 	    end 


    LDA: begin 
 	     PCload<=0; IRload<=0; JMPmux<=0; Meminst<=0; MemWr<=0; //内存不可以写�?
		  // 把Register输入ALU
		 RegWr<= 0; //读出模式
		 Asel0<=3'b000; 
		 sel01 <=0; 
 	     Aload<=1;  Halt<=0; 
 	 	end 

    STA: begin 
 	    PCload<=0; IRload<=0; JMPmux<=0; Meminst<=0; MemWr<=0; Asel0<=3'b000; 
		sel01 <=0;  RegWr <=1 ;   //内存读入A的�??
 	    Aload<=1;  Halt<=0; 
 	   end 

    LDM: begin 

 	    PCload<=0; IRload<=0; JMPmux<=0; Meminst<=1; MemWr<=0; Asel0<=3'b001; 
		sel01 = 0;
 	    Aload<=1;  Halt<=0; 
 	   end 

   STM: begin //绝对寻址
 	    PCload<=0; IRload<=0; JMPmux<=0; Meminst<=1; //绝对寻址
		Asel0<=3'b000; 
		MemWr =1 ;//存入内存RAM 
 	    Aload<=1;  Halt<=0; 
 	 	end 

   LDI: begin //RAM后八位直接给A
 	   PCload<=0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; 
		Asel0<=3'b010;  sel01 <= 0;
 	    Aload<=1;  Halt<=0; 
 	   end 

 	JMP:begin 
		if(Rjudge) begin
			PCload<=Aeq0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel0<=2'b00; 
			Jsel = 2'b01;   //
			Aload<=1;  Halt<=0;  
		end
		else 
			begin
			PCload<=Aeq0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel0<=2'b00; 
			Jsel =2'b10;
			Aload<=1;  Halt<=0; 
			end
 	   end 
    JZ:begin 
		if(Rjudge) begin   // 相对寻址跳转�?
			PCload<=Aeq0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel0<=2'b00; 
			Jsel = 2'b01;
			Aload<=1;  Halt<=0;  
		end
		else 
			begin   // 绝对跳转，把IR[5:0]输入进PC�?
			PCload<=Aeq0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel0<=2'b00; 
			Jsel = 2'b10;
			Aload<=1;  Halt<=0; 
			end
 	   end 
	JNZ:begin 
		if(Rjudge) begin
			PCload<=!Aeq0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel0<=2'b00; 
			Jsel = 2'b01;
			Aload<=1;  Halt<=0;  
		end
		else 
			begin
			PCload<=Aeq0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel0<=2'b00; 
			Jsel = 2'b10;
			Aload<=1;  Halt<=0; 
			end
 	   end 
	 JP:begin   // 相对跳转
		if(Rjudge) begin
			PCload<=Aeq0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel0<=2'b00; 
			Jsel = 2'b01;
			Aload<=1;  Halt<=0;  
		end
		else 
			begin
			PCload<=Aeq0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel0<=2'b00; 
			Jsel = 2'b10;
			Aload<=1;  Halt<=0; 
			end
 	   end 

	//  下面是和R(xxx)有关的数据计�? sel01 = 0;
	AND: begin 
 	   PCload<=0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel0<=3'b011; 
		sel01 = 0;
 	    Aload<=1;  Halt<=0; 
 	   end 
	OR: begin 
 	   PCload<=0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel0<=3'b100; 
		sel01 = 0;
 	    Aload<=1;  Halt<=0; 
 	   end 
	ADD: begin 
 	   PCload<=0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel0<=3'b101; 
		sel01 = 0;
 	    Aload<=1;  Halt<=0; 
 	   end 
	SUB: begin 
 	   PCload<=0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel0<=3'b110; 
		sel01 = 0;
 	    Aload<=1;  Halt<=0; 
 	   end 
	In: begin 
 	   PCload<=0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel1<=3'b111; 
		sel01 = 0;
 	    Aload<=1;  Halt<=0; 
 	end 
		//  下面是只和A有关的数据计�? sel01 = 1;
	NOT: begin  
 	   PCload<=0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel1<=3'b000; 
		sel01 = 1;
 	    Aload<=1;  Halt<=0; 
 	   end 
	INC: begin 
 	   PCload<=0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel1<=3'b001; 
		sel01 = 1;
 	    Aload<=1;  Halt<=0; 
 	   end 
	DEC: begin 
 	   PCload<=0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel1<=3'b010; 
		sel01 = 1;
 	    Aload<=1;  Halt<=0; 
 	   end 
	SHFL: begin 
 	   PCload<=0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel1<=3'b011; 
		sel01 = 1;
 	    Aload<=1;  Halt<=0; 
 	   end 
	SHFR: begin 
 	   PCload<=0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel1<=3'b100; 
		sel01 = 1;
 	    Aload<=1;  Halt<=0; 
 	   end 
	ROTR: begin 
 	   PCload<=0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel1<=3'b101; 
		sel01 = 1;
 	    Aload<=1;  Halt<=0; 
 	   end 
	OUT: begin 
 	   PCload<=0; IRload<=0; JMPmux<=1; Meminst<=0; MemWr<=0; Asel1<=3'b111; 
		sel01 = 0; out =1 ;        //信号统一首字母大�?
 	    Aload<=0;  Halt<=0; 
 	end 
 	HALT: begin 
 	     PCload<=0; IRload<=0; JMPmux<=0; Meminst<=0; MemWr<=0; Asel0<=2'b00; 
 	     Aload=0;  Halt<=1; 
 	 	end 
 	default: begin   
            PCload<=0; IRload<=0; JMPmux<=0; Meminst<=0; MemWr<=0;  
			sel01 = 0; out =0 ; 
             Aload=0; 
// NOP 也属于这�?�?
 	 	  end 
    endcase 
 end
end
 endmodule 




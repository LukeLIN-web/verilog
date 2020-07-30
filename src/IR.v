//实例化了 9 个子模块，即对应于图 10.19 中的指令寄存器 ir，2 选 1 多路选择器 mux21，程序指针寄存器 PC，累加单元，
//程序存储器 mem，4 选 1 多路选择器 mux41，累加器 a，
//加法-减法器 sub。对应于这些子模块的 Verilog 代码如下
//IR 模块程序 
module ir(D,load,Clear,clk,IR158 ,IR70 ); 

input load,Clear,clk; 
input [15:0] D; 

output reg [7:0] IR158; 
output reg [7:0] IR70; 

always @(posedge clk) 
begin 
if(Clear) 
	begin 
			IR158<=0; 
			IR70<=0; 
	end 

if(load)    // 把指令load进去,在CU判断.
	begin 
				IR158<=D[15:8]; 
				IR70<=D[7:0]; 
				 // for gengeral register load 
		// for memory load
	end 

end
endmodule 
 

//RAM memory模块 

module mem1(data,addr,qout,we,clk,reset); 

input[15:0]data; 
input reset;
 input [5:0]addr;
 input we,clk; 
output[15:0] qout; 
reg[15:0] qout; 
parameter memsize=64; //64*16位

reg[15:0] mem[memsize-1:0]; 
 
always @(posedge clk or posedge reset) 
if(reset) 
//如果reset那就初始化
begin   
//对 RAM 初始化 COUNT 指令 
 	mem[0]<=16'h1100;  	mem[1]<=0;  	mem[2]<=16'he300;  
	mem[3]<=0;  	mem[4]<=16'h5020; mem[5]<=0; mem[6]<=16'h403e; mem[7]<=16'h0000;
	mem[8]<=0; mem[9]<=16'h800b; mem[11]<=16'h603f;   
 	mem[63]<=16'hf200; 
end 
else begin  
 	if(we) 
      	mem[addr]<=data;  
			else  
	 	qout<=mem[addr]; 
	end 
endmodule 

//general register 模块 
module memR(data,addr,qout,we,clk,reset); 
input[15:0]data; 
input reset;
input [2:0]addr;
input we,clk; 
output[15:0] qout; 
reg[15:0] qout; 
parameter memsize=8; //8*16位
reg[15:0] mem[memsize-1:0]; 

always @(posedge clk or posedge reset ) if(reset) 
//如果reset那就初始化
begin   
//对 RAM 初始化 COUNT 指令 
 	mem[0]<=0;  	mem[1]<=1;  	mem[2]<=2;  
	mem[3]<=3;  	mem[4]<=4; mem[5]<=5;  mem[6]<=6;
	mem[7]<=7; 
end 
else begin  
 	if(we)   // we =1 读入, 
      mem[addr]<=data;   //读入
			else  
	 	qout<=mem[addr];  //写出
end 
endmodule 


//当前位置寄存器 PC 模块 
module pc(D50,load,Clear,clk,pc_addr);

input load,Clear,clk; 
input [5:0] D50; 
output reg [5:0] pc_addr; 

always @(posedge clk)  
if(Clear) 
    pc_addr<=0; 
else 
begin     
	if(load) 
            pc_addr<=D50;            
end 


endmodule 

//寄存器 A 模块 

module a(load,Clear,clk,D,Output,Apos,Aeq0 ); 

input load,Clear,clk; 
input [15:0] D; 
output reg [15:0] Output; 

output Apos,Aeq0; 
  

always @(posedge clk)  if(Clear) 
    Output<=0; 
else 
begin     if(load) 
            Output<=D;            
end 

assign Apos=~Output[15]; 

assign Aeq0=(Output==0)? 1:0; 

endmodule 
 
//sub & add 模块 
module sub(d,q,sub,ot ); 

input [7:0] d,q; 

input sub; 
output reg [7:0] ot; 
  
always @(d or q or sub) 

if(sub) ot=d-q; 
else ot=d+q; 


endmodule 

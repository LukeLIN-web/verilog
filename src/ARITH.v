module ARITH(Ain,Rin,Min,inputt,out1,out2,Asel0,Asel1,imm);
input[15:0] Ain,Rin,inputt,Min;
input[7:0] imm;
input[2:0] Asel0,Asel1;
output reg[15:0]out1,out2;

always@(*)
begin    
    case(Asel0)        
    3'b000:begin             out1 = Rin;               end        
    3'b001:begin             out1 = Min;               end   //
    3'b010:begin             out1 = imm;               end   //LDI immediate  A<-RAM 后八位;         
    3'b011:begin             out1 = Ain&&Rin;          end            
    3'b100:begin             out1 = Ain||Rin;          end     
    3'b101:begin             out1 = Ain+Rin;           end     
    3'b110:begin             out1 = Ain-Rin;           end   
    3'b111:begin             out1 = inputt;            end   
    default:begin            out1 = 0;            end    
    endcase

    case(Asel1)
    3'b000:begin             out2 <= ~Ain;               end        
    3'b001:begin             out2 <= Ain+1;               end        
    3'b010:begin             out2 <= Ain-1;               end   //LDI immediate           
    3'b011:begin             out2 <= Ain<<1;          end            
    3'b100:begin             out2 <= Ain>>1;          end     
    3'b101:begin             out2 <={Ain[0],Ain[15:1]};           end      
    default:begin            out2 <= 0;            end    
    endcase 
end

endmodule
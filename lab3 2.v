`timescale 1ns / 1ps 
module lab3_2(
			input[4:0] smartCode,
			input CLK, 
			input lab, //0:Digital, 1:Mera
			input [1:0] mode, //00:exit, 01:enter, 1x: idle 
			output reg [5:0] numOfStuInMera,
			output reg [5:0] numOfStuInDigital,
			output reg restrictionWarnMera,//1:show warning, 0:do not show warning
			output reg isFullMera, //1:full, 0:not full
			output reg isEmptyMera, //1: empty, 0:not empty
			output reg unlockMera,	//1:door is open, 0:closed
			output reg restrictionWarnDigital,//1:show warning, 0:do not show warning
			output reg isFullDigital, //1:full, 0:not full
			output reg isEmptyDigital, //1: empty, 0:not empty
			output reg unlockDigital //1:door is open, 0:closed
	);
	 
  	integer num ;
	
	initial begin
			numOfStuInMera=0;
			numOfStuInDigital=0;
			restrictionWarnMera=0;
			isFullMera=0;
			isEmptyMera=1'b1;
			unlockMera=0;		
			restrictionWarnDigital=0;
			isFullDigital=0;
			isEmptyDigital=1'b1;
			unlockDigital=0;
	end
	always @(posedge CLK)begin
      num=smartCode[0]+smartCode[1]+smartCode[2]+smartCode[3]+smartCode[4];
      if(mode==2'b01)begin
        if(lab==1'b0)begin
          if(isFullDigital==1'b0)begin
            if(numOfStuInDigital>=15)begin
              if(num%2==0)begin
                unlockDigital=1'b1;
                 numOfStuInDigital=numOfStuInDigital+1;
                 restrictionWarnDigital=1'b1;
                if(numOfStuInDigital==30)begin
                	 isFullDigital=1'b1;
                
                end
              end
              else begin
              	 unlockDigital=1'b0;
                 restrictionWarnDigital=1'b0;
              end
            end
            else begin
               unlockDigital=1'b1;
               numOfStuInDigital=numOfStuInDigital+1;    
            end
          end
          else begin
             unlockDigital=1'b0;
             restrictionWarnDigital=1'b0;
          end
        end
        else begin
          if(isFullMera==1'b0)begin
            if(numOfStuInMera>=15)begin
              if(num%2==1)begin
                 unlockMera=1'b1;
                 numOfStuInMera=numOfStuInMera+1;
                 restrictionWarnMera=1'b1;
                if(numOfStuInMera==30)begin
                	 isFullMera=1'b1;
                
                end
              end
              else begin
              	 unlockMera=1'b0;
                 restrictionWarnMera=1'b0;
              end
            end
            else begin
               unlockMera=1'b1;
               numOfStuInMera=numOfStuInMera+1;    
            end
          end
          else begin
             unlockMera=1'b0;
             restrictionWarnMera=1'b0;
          end
        end
      end
      if(mode ==2'b00)begin
        
        
        if(lab==1'b0) begin
          if(isEmptyDigital==1'b0) begin
             unlockDigital=1'b1;
             numOfStuInDigital=numOfStuInDigital-1;
          end
          if(numOfStuInDigital==0) begin
             unlockDigital=1'b0;
          end
        end
        
        
        else begin
          if(isEmptyMera==1'b0) begin
             unlockMera=1'b1;
             numOfStuInMera=numOfStuInMera-1;
          end
          if(numOfStuInMera==0) begin
             unlockMera=1'b0;
          end
        end
      
      end
      else begin 
		   restrictionWarnMera=1'b0;
		   restrictionWarnDigital=1'b0;
		   unlockMera=1'b0;
		   unlockDigital=1'b0;
		
		end
      if(numOfStuInDigital==6'b011110)begin
         isFullDigital=1'b1;
      end
      else begin 
         isFullDigital=1'b0;
      end
      if(numOfStuInDigital==6'b000000)begin
         isEmptyDigital=1'b1;
      end
      else begin
         isEmptyDigital=1'b0;
      end
      if(numOfStuInMera==6'b011110)begin
         isFullMera=1'b1;
      end
      else begin 
         isFullMera=1'b0;
      end
      if(numOfStuInMera==6'b000000)begin
         isEmptyMera=1'b1;
      end
      else begin
         isEmptyMera=1'b0;
      end
	end
	
endmodule


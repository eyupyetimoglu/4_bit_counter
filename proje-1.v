//first we must declare our counter 
module sync_counter(clock,inputs,reset,redge,cnt);
  input wire clock, reset, redge; //our inputs 
  input wire [3:0] inputs; //4-bit inputs like q0,q1,q2,q3
  
  output reg [3:0] cnt; //4-bit output like Q0,Q1,Q2,Q3
  
  always@(posedge clock) begin //This 'always' code block allows us to execute sequentially
    if(reset)
      cnt<=4'b0000; //when the reset input is on "1" count variable immediately changes to 0
    else if(redge)
      cnt<=inputs+1; //whe the rising_edge triggers count variable will update its data
  end
endmodule


module testbench_counter;
  reg clock, reset,redge;
  reg [3:0] inputs;
  
  wire [3:0] cnt;
  
  sync_counter sync_counter_i(.clock(clock), .reset(reset), .redge(redge), .inputs(inputs), .cnt(cnt)); 
  //our counter instance which makes
  
  initial begin 
    clock=1'b0;
    forever #1 clock=~clock; // it generate the clock signals
  end
  
  initial begin
    reset=1'b1; // it will start with reset active
    redge=1'b1; // it will set the rising_edge="1"
    inputs=4'b0000; // inputs begin with decimal 0
    
    #1 reset=1'b0; //deactive the reset 
    
    repeat(16) begin //repeats the same steps 16 times
      #2 inputs = inputs + 1;
    end
    $finish;
  end
  
  initial begin 
    $monitor("reset=%b----is_rising_edge_on=%b----q3,q2,q1,q0=%b----Q3,Q2,Q1,Q0=%b",reset,redge,inputs,cnt);
  end
endmodule
    
    




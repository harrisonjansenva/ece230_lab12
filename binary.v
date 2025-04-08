// Implement binary state machine
module binary (
    input w,
    input clk,
    input reset,
    output z,
    output[2:0] state
    
);
wire [2:0] next;

dff bzero(
    .Default(1'b1),
    .D(next[0]),
    .clk(clk),
    .Q(state[0])
    );
    
dff bone (
    .Default(1'b0),
    .D(next[1]),
    .clk(clk),
    .Q(state[1])
    );
    
dff btwo (
    .Default(1'b0),
    .D(next[2]),
    .clk(clk),
    .Q(state[2])
    );
    
    assign next[0] = (state[0] & ~w) | (state == 3'b011 & ~w) | (state == 3'b100 & ~w);
    assign next[1] = (state == 3'b001 & ~w) | (state == 3'b010 & ~w);
    assign next[2] = (state == 3'b011 & w) | (state == 3'b100);
    
    assign z = (state == 3'b010) | (state == 3'b100); 
    
    



endmodule


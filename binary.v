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
    
    assign state[0] = 
    (state[0] & ~w) | (state[1] & ~w) | (state[2] & ~w);
    assign state[1] =
    (state[0] & w) | (state[1] & ~w) | (state[2] & ~w);
    assign state[2] =
    (state[0] & ~w) | (state[1] & w) | (state[2] & w);
    assign next[0] = 1'b0;
    assign next[1] = (state[0] & ~w) | (state[1] & ~w) | (state[2] & ~w);
    assign next[2] = (state[0] & w) | (state[1] & w) | (state[2] & w);
    
    assign z = (state == 3'b010) | (state == 3'b100); 
    
    



endmodule
module binary (
    input w,
    input clk,
    input reset,
    output z,
    output [2:0] state  // Binary encoded state: A = 000, B = 001, C = 010, D = 011, E = 100.
);

    wire [2:0] next;
    // For convenience, let S2 = state[2], S1 = state[1], S0 = state[0].
    wire S2, S1, S0;
    assign {S2, S1, S0} = state;

    // Instantiate three D flip-flops for the 3-bit state.
    // Set the default so that on reset the state is A (000).
    dff dff0 (
        .Default(1'b0),
        .D(next[0]),
        .clk(clk),
        .reset(reset),
        .Q(state[0])
    );
    
    dff dff1 (
        .Default(1'b0),
        .D(next[1]),
        .clk(clk),
        .reset(reset),
        .Q(state[1])
    );
    
    dff dff2 (
        .Default(1'b0),
        .D(next[2]),
        .clk(clk),
        .reset(reset),
        .Q(state[2])
    );

    // Next-state logic derived from the lab table (using one set of acceptable equations):

    // For the MSB (N2):
    assign next[2] = w & ( (~S2 & S1 & S0) | (S2 & ~S1 & ~S0) );
    // For the middle bit (N1):
    assign next[1] = ((~S2 & ~S1 & S0) | (~S2 & S1 & ~S0)) | ((~S2 & ~S1 & ~S0) & w);
    // For the LSB (N0):
    assign next[0] = (~S2 & ~S1 & ~S0)
                     | ((~S2 & ~S1 & S0) & w)
                     | ((~S2 & S1 & ~S0) & w)
                     | ((~S2 & S1 & S0) & ~w)
                     | ((S2 & ~S1 & ~S0) & ~w);

    // Output z: z is 1 when in state C (3'b010) or state E (3'b100).
    assign z = ((state == 3'b010) || (state == 3'b100));

endmodule


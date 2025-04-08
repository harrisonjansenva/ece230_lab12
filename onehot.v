module onehot (
    input w,
    input clk,
    input reset,
    output z,
    output [4:0] state
);
wire Anext, Bnext, Cnext, Dnext, Enext;

dff A(
    .Default(1'b1),
    .D(Anext),
    .clk(clk),
    .reset(reset),
    .Q(state[0])
);
dff B(
    .Default(1'b0),
    .D(Bnext),
    .clk(clk),
    .reset(reset),
    .Q(state[1])
);
dff C(
    .Default(1'b0),
    .D(Cnext),
    .clk(clk),
    .reset(reset),
    .Q(state[2])
);
dff D(
    .Default(1'b0),
    .D(Dnext),
    .clk(clk),
    .reset(reset),
    .Q(state[3])
);
dff E(
    .Default(1'b0),
    .D(Enext),
    .clk(clk),
    .reset(reset),
    .Q(state[4])
);
assign z = state[4] | state[2];
assign Anext = 1'b0;
assign Bnext = (state[0] & ~w) | (state[3] & ~w) | (state[4] & ~w);
assign Cnext = (state[1] & ~w) | (state[2] & ~w);
assign Dnext = (state[0] & w) | (state[1] & w) | (state[2] & w);
assign Enext = (state[3] & w) | (state[4] & w);

endmodule


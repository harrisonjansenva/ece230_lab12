module top(
    input sw, // w
    output [9:0] led, // see IO table
    input btnC, // clk
    input btnU // reset
);


onehot onehotmod (
    .w(sw),
    .clk(btnC),
    .reset(btnU),
    .z(led[0]),
    .state(led[6:2])
    );
binary binarymod(
    .w(sw),
    .clk(btnC),
    .z(led[1]),
    .reset(btnU),
    .state(led[9:7])
    );



    

    // Hook up binary and one-hot state machines

endmodule

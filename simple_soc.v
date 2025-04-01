module simple_soc(
    // Input
    input wire clk,         // Clock input 
    input wire reset,       // Reset input 
    input wire enable,      // Enable counting 
    output wire [3:0] count,    // Counter output 
    output wire match           // Comparator output  
);
    // Instantiate the counter
    simple_counter counter_inst(
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .count(count)
    ); 

    // Instantiate the comparator
    comparator comp_inst(
        .count(count),
        .match(match)
    ); 
endmodule 

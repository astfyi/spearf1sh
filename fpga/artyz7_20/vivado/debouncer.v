`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2021 12:26:47 PM
// Design Name: 
// Module Name: debouncer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module debouncer(
    input clk,
    input n_rst,
    input btn_i,
    output reg btn_o
    );
    
    // assuming 100mhz input clock, 2^(22-1)/100000000 = 0.02 or 20ms debounce
    parameter N = 22;
    
    reg[N-1:0] count;
    reg[N-1:0] count_next;
    reg DFF1, DFF2;
    
    wire q_add;
    wire q_reset;
    
    assign q_reset = (DFF1 ^ DFF2);
    assign q_add = ~(count[N-1]);
    
    always @ (posedge clk)
    begin
        if (n_rst == 1'b0)
        begin
            DFF1 <= 1'b0;
            DFF2 <= 1'b0;
            count <= { N {1'b0} };
        end
        else
        begin
            DFF1 <= btn_i;
            DFF2 <= DFF1;
            count <= count_next;
        end
    end
    
    always @ (q_reset, q_add, count)
    begin
        case({q_reset, q_add})
            2'b00:
                count_next <= count;
            2'b01:
                count_next <= count + 1;
            default:
                count_next <= { N {1'b0} };
        endcase
    end
    
    always @ (posedge clk)
    begin
        if (count[N-1] == 1'b1)
            btn_o <= DFF2;
        else
            btn_o <= btn_o;
    end
    
endmodule

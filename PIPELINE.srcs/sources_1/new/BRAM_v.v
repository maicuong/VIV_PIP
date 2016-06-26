module  BRAM_v  (clk, we,  addr,  din,  dout);
    input  clk;
    input  we;
    input  [4:0]    addr;
    input  [15:0]    din;
    output  [15:0]    dout;
    reg  [15:0]  ram  [0:31];
    reg  [15:0]  dout;
    
    //initial begin
        //$readmemh("rams_20c.data",ram,  0,  31);
    //end
    
    always  @(posedge  clk) begin
        if  (we)
            ram[addr]  <=  din;
            
        dout  <=  ram[addr];
    end
endmodule
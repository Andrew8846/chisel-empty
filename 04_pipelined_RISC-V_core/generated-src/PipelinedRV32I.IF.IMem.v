module BindsTo_0_IF(
  input         clock,
  input  [31:0] io_pc,
  output [31:0] io_instr,
  output [31:0] io_pcNew
);

initial begin
  $readmemh("src/test/programs/BinaryFile", IF.IMem);
end
                      endmodule

bind IF BindsTo_0_IF BindsTo_0_IF_Inst(.*);
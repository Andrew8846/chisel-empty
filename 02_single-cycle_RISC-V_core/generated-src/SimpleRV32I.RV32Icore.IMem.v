module BindsTo_0_RV32Icore(
  input         clock,
  input         reset,
  output [31:0] io_check_res
);

initial begin
  $readmemh("src/test/programs/BinaryFile", RV32Icore.IMem);
end
                      endmodule

bind RV32Icore BindsTo_0_RV32Icore BindsTo_0_RV32Icore_Inst(.*);
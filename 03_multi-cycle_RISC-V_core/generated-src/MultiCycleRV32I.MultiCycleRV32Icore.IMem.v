module BindsTo_0_MultiCycleRV32Icore(
  input         clock,
  input         reset,
  output [31:0] io_check_res
);

initial begin
  $readmemh("src/test/programs/BinaryFile", MultiCycleRV32Icore.IMem);
end
                      endmodule

bind MultiCycleRV32Icore BindsTo_0_MultiCycleRV32Icore BindsTo_0_MultiCycleRV32Icore_Inst(.*);
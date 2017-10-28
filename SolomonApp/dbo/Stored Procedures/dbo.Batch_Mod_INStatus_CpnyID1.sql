 /****** Object:  Stored Procedure dbo.Batch_Mod_INStatus_CpnyID1  ******/
Create Proc Batch_Mod_INStatus_CpnyID1 @parm1 varchar ( 2), @parm2 varchar ( 10) as
       Select * from Batch
           where Module   =   @parm1
             and CpnyId Like  @parm2
             and Status   IN ('B', 'S', 'I')
           order by Module, BatNbr



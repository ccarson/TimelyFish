 /****** Object:  Stored Procedure dbo.Batch_Mod_Rlsed_BCR1_CpnyID    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_Mod_Rlsed_BCR1_CpnyID @parm1 varchar ( 2), @parm2 varchar ( 10), @parm3 varchar ( 10), @parm4 varchar ( 10) as
       Select * from Batch
           where Module  = @parm1
             and CpnyId = @parm2
                 and Rlsed = 1
             and BatNbr between @parm3 and @parm4
	     and Status <> 'V'
           order by Module, Rlsed, BatNbr



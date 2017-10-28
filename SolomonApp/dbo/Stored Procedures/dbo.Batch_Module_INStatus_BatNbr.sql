 /****** Object:  Stored Procedure dbo.Batch_Module_INStatus_BatNbr    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_Module_INStatus_BatNbr @parm1 varchar ( 2), @parm2 varchar ( 10), @parm3 varchar ( 10) as
       Select * from Batch
           where Module = @parm1
             and ( ( (Module = 'GL') and (Status IN ( 'H', 'B', 'U', 'P')) )

                   or
                   ( (Module <> 'GL') and (Status IN ( 'U', 'P')) )
                   or
                   ( (Module IN ('PA', 'BI', 'TE', 'TM')) and (Status = 'H') )
                   or
			-- These are TE Pay Labor Interface batches
                   ( (Module = 'PR' and JrnlType = 'TM' and (EditScrnNbr = '58010' or EditScrnNbr = '02020')) and (Status = 'H') )
                 )
             and CpnyId = @parm2
             and BatNbr  LIKE @parm3
           order by Module, BatNbr



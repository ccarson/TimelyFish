 /****** Object:  Stored Procedure dbo.Batch_OrigScrnNbr_Module    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_OrigScrnNbr_Module @parm1 varchar ( 5), @parm2 varchar ( 2), @parm3 varchar ( 10) as
       Select * from Batch where OrigScrnNbr = @parm1
             and Module  = @parm2
         and BatNbr LIKE  @parm3
         order by OrigScrnNbr, BatNbr DESC



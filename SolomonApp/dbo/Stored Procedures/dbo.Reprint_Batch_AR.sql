 /****** Object:  Stored Procedure dbo.Reprint_Batch_AR    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Reprint_Batch_AR @parm1 varchar ( 10), @parm2 varchar ( 10) as
       Select * from Batch
           where Module  = "AR"
             and Rlsed =  1
             and cpnyid like @parm1
             and BatNbr  LIKE @parm2
             and Status <> 'V'
           order by BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Reprint_Batch_AR] TO [MSDSL]
    AS [dbo];


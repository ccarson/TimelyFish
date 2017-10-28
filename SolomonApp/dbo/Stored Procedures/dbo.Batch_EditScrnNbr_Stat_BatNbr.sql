 /****** Object:  Stored Procedure dbo.Batch_EditScrnNbr_Stat_BatNbr    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_EditScrnNbr_Stat_BatNbr @parm1 varchar ( 5), @parm2 varchar ( 1), @parm3 varchar ( 10) as
       Select * from Batch
           where EditScrnNbr    =  @parm1
             and Status         =  @parm2
             and BatNbr      LIKE  @parm3
           order by EditScrnNbr, BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Batch_EditScrnNbr_Stat_BatNbr] TO [MSDSL]
    AS [dbo];


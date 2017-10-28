 /****** Object:  Stored Procedure dbo.Batch_EditScrnNbr_BatNbr_Stat    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_EditScrnNbr_BatNbr_Stat @parm1 varchar ( 5), @parm2 varchar ( 10) as
       Select * from Batch
           where EditScrnNbr    =  @parm1
             and BatNbr      LIKE  @parm2
             and Status        IN  ('H', 'B')
           order by EditScrnNbr, BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Batch_EditScrnNbr_BatNbr_Stat] TO [MSDSL]
    AS [dbo];


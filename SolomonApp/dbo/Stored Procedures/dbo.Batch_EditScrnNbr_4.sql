Create Proc [dbo].[Batch_EditScrnNbr_4] @parm1 varchar ( 5), @parm2 varchar ( 10) as
       Select * from Batch
           where EditScrnNbr =    @parm1
             and BatNbr      like @parm2
			 and Status <> 'V'
           order by EditScrnNbr, BatNbr 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Batch_EditScrnNbr_4] TO [MSDSL]
    AS [dbo];


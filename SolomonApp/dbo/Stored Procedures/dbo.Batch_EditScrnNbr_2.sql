 /****** Object:  Stored Procedure dbo.Batch_EditScrnNbr_2    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_EditScrnNbr_2 @parm1 varchar ( 5), @parm2 varchar ( 5), @parm3 varchar ( 2), @parm4 varchar ( 10) as
       Select * from Batch
           where (EditScrnNbr = @parm1 OR EditScrnNbr = @parm2)
             and module = @parm3
             and BatNbr like @parm4
           order by BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Batch_EditScrnNbr_2] TO [MSDSL]
    AS [dbo];


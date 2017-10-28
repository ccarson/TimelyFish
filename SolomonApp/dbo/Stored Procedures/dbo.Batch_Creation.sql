
/****** Object:  Stored Procedure dbo.Batch_EditScrnNbr    Script Date: 4/7/98 12:38:58 PM ******/
CREATE  Proc Batch_Creation @parm1 varchar ( 5), @parm2 varchar ( 10) as
       Select * from Batch
           where EditScrnNbr =    @parm1
             and BatNbr      like @parm2
           order by EditScrnNbr, BatNbr 



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Batch_Creation] TO [MSDSL]
    AS [dbo];


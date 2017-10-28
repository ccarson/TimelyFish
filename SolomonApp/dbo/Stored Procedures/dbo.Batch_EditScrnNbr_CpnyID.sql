 /****** Object:  Stored Procedure dbo.Batch_EditScrnNbr_CpnyID    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_EditScrnNbr_CpnyID @parm1 varchar ( 10), @parm2 varchar ( 5), @parm3 varchar ( 10) as
       Select * from Batch where
        CpnyID = @parm1
        and EditScrnNbr = @parm2
        and BatNbr like @parm3
        order by CpnyID, BatNbr, EditScrnNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Batch_EditScrnNbr_CpnyID] TO [MSDSL]
    AS [dbo];


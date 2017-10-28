 /****** Object:  Stored Procedure dbo.Batch_EditScrnNbr_Cpny_3    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc Batch_EditScrnNbr_Cpny_3 @parm1 varchar ( 10), @parm2 varchar ( 5), @parm3 varchar ( 5),@parm4 varchar (5), @parm5 varchar ( 2), @parm6 varchar ( 10) as
       Select * from Batch
           where
             CpnyId = @parm1
             and (EditScrnNbr = @parm2 OR EditScrnNbr = @parm3 OR EditScrnNbr = @parm4)
             and module = @parm5
             and BatNbr like @parm6
                        and Status <> 'K'
                        and Status <> 'R'
           order by CpnyId, BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Batch_EditScrnNbr_Cpny_3] TO [MSDSL]
    AS [dbo];


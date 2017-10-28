 /****** Object:  Stored Procedure dbo.DeleteRCAPDoc    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure DeleteRCAPDoc @parm1 varchar ( 10), @parm2 varchar ( 2) As

Delete From APDoc Where
APDoc.RefNbr = @parm1 and
APDoc.DocType = @parm2
IF @@ERROR <> 0 GOTO ABORT

Delete From APTran Where
APTran.RefNbr = @parm1 and
APTran.TranType = @parm2
IF @@ERROR <> 0 GOTO ABORT

ABORT:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteRCAPDoc] TO [MSDSL]
    AS [dbo];


 /****** Object:  Stored Procedure dbo.KeepAPCheckTran    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure KeepAPCheckTran @parm1 varchar ( 10), @parm2 varchar ( 15) As
Select * From APCheckDet Where
BatNbr = @parm1 and
CheckRefNbr = @parm2
Order By RefNbr, DocType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[KeepAPCheckTran] TO [MSDSL]
    AS [dbo];


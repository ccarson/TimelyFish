 /****** Object:  Stored Procedure dbo.FSTrslDet_Delete    Script Date: 4/7/98 12:45:04 PM ******/
Create Procedure FSTrslDet_Delete @parm1 varchar ( 10) as
     Delete fstrsldet from FSTrslDet
     where FSTrslDet.RefNbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FSTrslDet_Delete] TO [MSDSL]
    AS [dbo];


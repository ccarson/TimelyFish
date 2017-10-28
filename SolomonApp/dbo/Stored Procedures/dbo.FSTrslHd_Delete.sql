 /****** Object:  Stored Procedure dbo.FSTrslHd_Delete    Script Date: 4/7/98 12:45:04 PM ******/
Create Procedure FSTrslHd_Delete @parm1 varchar ( 6) as
     Select * from FSTrslHd where PerPost <= @parm1 and PerPost <> ' '
     Order by PerPost, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FSTrslHd_Delete] TO [MSDSL]
    AS [dbo];


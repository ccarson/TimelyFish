 /****** Object:  Stored Procedure dbo.DeleteAPTran_BatNbr    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure DeleteAPTran_BatNbr @parm1 varchar ( 10) As
Delete aptran from APTran Where BatNbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteAPTran_BatNbr] TO [MSDSL]
    AS [dbo];


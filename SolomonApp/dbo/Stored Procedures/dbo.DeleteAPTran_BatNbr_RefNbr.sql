 /****** Object:  Stored Procedure dbo.DeleteAPTran_BatNbr_RefNbr    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure DeleteAPTran_BatNbr_RefNbr @parm1 varchar ( 10), @parm2 varchar ( 10) As
Delete aptran from APTran Where BatNbr = @parm1
and RefNbr = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteAPTran_BatNbr_RefNbr] TO [MSDSL]
    AS [dbo];


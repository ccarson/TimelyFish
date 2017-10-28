 /****** Object:  Stored Procedure dbo.DelTempChkTranEa    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure DelTempChkTranEa @parm1 varchar ( 15) As
Delete aptran from APTran Where
APTran.ExtRefNbr = @parm1 and
APTran.BatNbr = '' and
APTran.AcctDist = 0 and
APTran.Rlsed = 0 and
APTran.DrCr = 'S'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DelTempChkTranEa] TO [MSDSL]
    AS [dbo];


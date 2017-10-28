 /****** Object:  Stored Procedure dbo.DeleteTempCheckTran    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure DeleteTempCheckTran As
Delete from APTran Where
BatNbr = '' and
Acct = '' and
Sub = '' and
DrCr = 'S'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteTempCheckTran] TO [MSDSL]
    AS [dbo];


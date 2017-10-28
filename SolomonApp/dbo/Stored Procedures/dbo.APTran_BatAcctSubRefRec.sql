 Create Procedure APTran_BatAcctSubRefRec @BatNbr varchar (10), @Acct varchar (10), @Sub varchar(24),@RefNbr varchar(10), @RecordID Integer As
Select * from APtran
	Where BatNbr = @BatNbr
	AND Acct = @Acct
	AND Sub = @Sub
	AND RefNbr = @RefNbr
	AND RecordID = @RecordID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[APTran_BatAcctSubRefRec] TO [MSDSL]
    AS [dbo];


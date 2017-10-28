
Create Proc vs_AcctXRef_Acct_w @parm1 varchar ( 10), @parm2 varchar ( 10) AS
Select acct from vs_AcctXRef where CpnyID = @parm1 and Active = 1 and Acct = @parm2


GO
GRANT CONTROL
    ON OBJECT::[dbo].[vs_AcctXRef_Acct_w] TO [MSDSL]
    AS [dbo];


 CREATE Procedure RQ_AcctXref

	@CpnyID varchar(10),
	@UserID varchar(47),
	@Acct varchar(10)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

	select	vs_AcctXRef.Acct, vs_AcctXref.Active
	from	vs_AcctXRef
	where	CpnyID = @CpnyID
	and	Acct like @Acct
	and	Active = 1
	and  	Acct in (Select Acct from RQUserAcct where UserID = @UserID)
	order by Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQ_AcctXref] TO [MSDSL]
    AS [dbo];


 CREATE Procedure RQ_AcctXref_Project

	@CpnyID varchar(10),
	@UserID varchar(47),
	@Acct varchar(10)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

	select	vs_AcctXref.Acct, vs_AcctXref.Active
	from	vs_AcctXref
	join	PJ_Account on vs_AcctXref.Acct = Pj_Account.gl_Acct
	where	vs_AcctXref.CpnyID = @CpnyID
	and	vs_AcctXRef.Acct in (Select Acct from RQUserAcct where UserID = @UserID)
	and	vs_AcctXref.Acct like @Acct
	and	vs_AcctXref.Active = 1
	order by vs_AcctXref.Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQ_AcctXref_Project] TO [MSDSL]
    AS [dbo];


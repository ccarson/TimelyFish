 CREATE Procedure RQ_AcctSub_Project

	@CpnyID varchar(10),
	@UserID varchar(47),
	@Acct varchar(10)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as

	select	vs_AcctSub.Acct, vs_AcctSub.Active
	from	vs_AcctSub
	join	PJ_Account on vs_AcctSub.Acct = Pj_Account.gl_Acct
	where	vs_AcctSub.CpnyID = @CpnyID
	and  	vs_AcctSub.Acct in (Select Acct from RQUserAcct where UserID = @UserID)
	and	vs_AcctSub.Acct like @Acct
	and	vs_AcctSub.Active = 1
	order by vs_AcctSub.Acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[RQ_AcctSub_Project] TO [MSDSL]
    AS [dbo];


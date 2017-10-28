 create procedure DMG_AcctSub_PJ_Account_Account_Valid
	@CpnyID	varchar(10),
	@Acct	varchar(10)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	if (
	select	count(*)
	from	vs_AcctSub (NOLOCK)
	join	PJ_Account (NOLOCK) on vs_AcctSub.Acct = Pj_Account.gl_Acct
	where	vs_AcctSub.CpnyID = @CpnyID
	and	vs_AcctSub.Acct = @Acct
	and	vs_AcctSub.Active = 1
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_AcctSub_PJ_Account_Account_Valid] TO [MSDSL]
    AS [dbo];


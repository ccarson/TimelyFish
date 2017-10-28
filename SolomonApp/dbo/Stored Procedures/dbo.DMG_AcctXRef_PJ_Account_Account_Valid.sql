 create procedure DMG_AcctXRef_PJ_Account_Account_Valid
	@CpnyID	varchar(10),
	@Acct	varchar(10)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	if (
	select	count(*)
	from	vs_AcctXRef (NOLOCK)
	join	PJ_Account (NOLOCK) on vs_AcctXRef.Acct = Pj_Account.gl_Acct
	where	vs_AcctXRef.CpnyID = @CpnyID
	and	vs_AcctXRef.Acct = @Acct
	and	vs_AcctXRef.Active = 1
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_AcctXRef_PJ_Account_Account_Valid] TO [MSDSL]
    AS [dbo];


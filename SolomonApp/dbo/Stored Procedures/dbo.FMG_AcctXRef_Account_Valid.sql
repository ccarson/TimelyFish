 create procedure FMG_AcctXRef_Account_Valid
	@CpnyID	varchar(10),
	@Acct	varchar(10)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	if (
	select	count(*)
	from	vs_AcctXRef (NOLOCK)
	where	CpnyID = @CpnyID
	and	Acct = @Acct
	and	Active = 1
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



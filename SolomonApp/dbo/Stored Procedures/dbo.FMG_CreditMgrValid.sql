 create procedure FMG_CreditMgrValid
	@CreditMgrID	varchar(10)
as
	if (
	select	count(*)
	from	CreditMgr (NOLOCK)
	where	CreditMgrID = @CreditMgrID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



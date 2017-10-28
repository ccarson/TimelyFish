 create procedure DMG_CustIDValid
	@CustID		varchar(15)
as
	if (
	select	count(*)
	from	Customer (NOLOCK)
	where	CustID = @CustID
	and	Status IN ('A', 'O', 'R')
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CustIDValid] TO [MSDSL]
    AS [dbo];


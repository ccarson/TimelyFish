 create procedure DMG_ShipToIDValid
	@CustID		varchar(15),
	@ShipToID	varchar(10)
as
	if (
	select	count(*)
	from	SOAddress (NOLOCK)
	where	CustID = @CustID
	and	ShipToID = @ShipToID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ShipToIDValid] TO [MSDSL]
    AS [dbo];


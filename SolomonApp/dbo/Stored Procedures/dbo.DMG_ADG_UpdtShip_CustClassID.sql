 create proc DMG_ADG_UpdtShip_CustClassID
	@CustID		varchar(15),
	@ClassID	varchar(6) OUTPUT
as

	-- Initialize output parameter
	set @ClassID = ''

	select	@ClassID = ltrim(ClassID)
	from	Customer
	where	CustID = @CustID

	if @ClassID = '' begin
		return 0	-- Failure
	end
	else
		return 1	-- Success


GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ADG_UpdtShip_CustClassID] TO [MSDSL]
    AS [dbo];


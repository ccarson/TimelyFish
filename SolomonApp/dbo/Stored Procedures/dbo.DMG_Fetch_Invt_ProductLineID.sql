 create proc DMG_Fetch_Invt_ProductLineID
	@InvtID		varchar(30),
	@ProdLineID	varchar(4) OUTPUT
as

	-- Initialize output parameter
	set @ProdLineID = ''

	select	@ProdLineID = ltrim(ProdLineID)
	from	InventoryADG
	where	InvtID = @InvtID

	if @ProdLineID = '' begin
		return 0	-- Failure
	end
	else
		return 1	-- Success


GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Fetch_Invt_ProductLineID] TO [MSDSL]
    AS [dbo];


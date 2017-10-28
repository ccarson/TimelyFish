 create proc ADG_Inventory_ItemProperties
	@InvtID		varchar(30)
as
	select	left(I.LotSerTrack, 1) ItemType,
		I.LotSerIssMthd,
		I.LotSerTrack,
		A.ProdLineID,
		I.S4Future09,
		I.SerAssign,
		I.ShelfLife,
		I.StkItem,
		I.TranStatusCode,
		I.ValMthd,
		I.WarrantyDays,
		I.LinkSpecID

	from	Inventory I (nolock)

	join	InventoryADG A (nolock)
	on	I.InvtID = A.InvtID

	where	I.InvtID = @InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Inventory_ItemProperties] TO [MSDSL]
    AS [dbo];


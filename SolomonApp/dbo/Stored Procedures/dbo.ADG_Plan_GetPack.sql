 create proc ADG_Plan_GetPack
	@InvtID		varchar(30)
as
	select	Pack,
		PackCnvFact,
		PackMethod,
		PackSize,
		PackUnitMultDiv,
		StdCartonBreak

	from	InventoryADG

	where	InvtID = @InvtID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Plan_GetPack] TO [MSDSL]
    AS [dbo];


 create procedure DMG_PO_ItemXRefSelectedByInvtID
	@InvtID		varchar(30),
	@EntityID	varchar(15),
	@AltIDType	varchar(1),
	@StkItem	bit,
	@AlternateID	varchar(30) OUTPUT,
	@Descr		varchar(60) OUTPUT
as
	-- Look for customer specific records first
	select	top 1
		@AlternateID = ltrim(rtrim(AlternateID)),
		@Descr = ltrim(rtrim(ItemXRef.Descr))
	from	ItemXRef (NOLOCK)
	join	Inventory (NOLOCK) on Inventory.InvtID = ItemXRef.InvtID
	where	((EntityID = @EntityID and AltIDType = @AltIDType)
	or	AltIDType Not in ('C', 'V'))
	and	ItemXRef.InvtID = @InvtID
	and	Inventory.StkItem = @StkItem
        order by AltIDType Desc, ItemXRef.InvtID, EntityID

	if @@ROWCOUNT <> 0
		--select @AlternateID, @Descr
		return 1	--Success
	else begin
		set @AlternateID = ''
		set @Descr = ''
		return 0	--Failure
	end



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_ItemXRefSelectedByInvtID] TO [MSDSL]
    AS [dbo];


 create procedure DMG_GetComponentQty
	@KitID		varchar(30),
	@CmpnentID	varchar(30),
	@CmpnentQty	decimal(25,9) OUTPUT
as
	select	@CmpnentQty = CmpnentQty
	from	Component (NOLOCK)
	where	KitID = @KitID
	and	CmpnentID = @CmpnentID

	if @@ROWCOUNT = 0 begin
		set @CmpnentQty = 0
		return 0	--Failure
	end
	else begin
		--select @CmpnentQty
		return 1	--Success
	end



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_GetComponentQty] TO [MSDSL]
    AS [dbo];


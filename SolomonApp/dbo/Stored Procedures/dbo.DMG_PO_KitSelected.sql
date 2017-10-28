 create procedure DMG_PO_KitSelected
	@KitID 		varchar(30),
	@ExpKitDet 	smallint OUTPUT,
	@KitType	varchar(1) OUTPUT
as
	select	@ExpKitDet = ExpKitDet,
		@KitType = ltrim(rtrim(KitType))
	from	Kit (NOLOCK)
	where	KitId = @KitID

	if @@ROWCOUNT = 0 begin
		set @ExpKitDet = 0
		set @KitType = ''
		return 0	--Failure
	end
	else begin
		--select @ExpKitDet
		return 1	--Success
	end



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PO_KitSelected] TO [MSDSL]
    AS [dbo];


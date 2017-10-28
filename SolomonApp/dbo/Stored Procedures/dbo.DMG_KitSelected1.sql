 create procedure DMG_KitSelected1
	@KitID 		varchar(30),
	@ExpKitDet 	smallint OUTPUT,
	@KitType	varchar(1) OUTPUT
as
	select	@ExpKitDet = ExpKitDet,
		@KitType = KitType
	from	Kit (NOLOCK)
	where	Kit.KitId = @KitID

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
    ON OBJECT::[dbo].[DMG_KitSelected1] TO [MSDSL]
    AS [dbo];


 create procedure DMG_PO_BOM_KitSelected
	@KitID 		varchar(30),
	@BOMSiteID	varchar(10),
	@DfltSiteID	varchar(10),
	@Status		varchar(1),
	@ExpKitDet 	smallint OUTPUT,
	@KitSiteID	varchar(10) OUTPUT,
	@KitType	varchar(1) OUTPUT
as
	select	@ExpKitDet = ExpKitDet,
		@KitSiteID = ltrim(rtrim(SiteID)),
		@KitType = ltrim(rtrim(KitType))
	from	Kit (NOLOCK)
	where	KitId = @KitID
	and	SiteID = @BOMSiteID
	and	Status = @Status

	if @@ROWCOUNT = 0 begin

		--If the two sites are different try querying on the default site
		if @DfltSiteID <> @BOMSiteID begin

			select	@ExpKitDet = ExpKitDet,
				@KitSiteID = ltrim(rtrim(SiteID)),
				@KitType = ltrim(rtrim(KitType))
			from	Kit (NOLOCK)
			where	KitId = @KitID
			and	SiteID = @DfltSiteID
			and	Status = @Status

			if @@ROWCOUNT = 0 begin
				set @ExpKitDet = 0
				set @KitType = ''
				return 0	--Failure
			end
			else
				return 1	--Success
		end
		else
			set @ExpKitDet = 0
			set @KitType = ''
			return 0	--Failure
	end
	else
		return 1	--Success



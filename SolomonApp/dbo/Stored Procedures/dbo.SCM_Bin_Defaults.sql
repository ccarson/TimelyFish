 create procedure SCM_Bin_Defaults
	@CpnyID varchar(10),
	@InvtID varchar(30),
	@ClassID varchar(6),
	@SiteID varchar(10),
	@PutAwayBin varchar(10) OUTPUT,
	@PickBin varchar(10) OUTPUT,
	@RepairBin varchar(10) OUTPUT,
	@VendorBin varchar(10) OUTPUT
as
	declare @DfltSiteID varchar(10)

	--Initialize the return values in case all the below falls through
	set @PutAwayBin = ''
	set @PickBin = ''
	set @RepairBin = ''
	set @VendorBin = ''
	set @DfltSiteID = ''

	--Return blank values if no company is passed
	if @CpnyID = ''
	begin
		return 1
	end

	--If the key data exists
	if @InvtID <> '' and @SiteID <> ''
	begin
		set @DfltSiteID = @SiteID

		--Lookup the bins from ItemSite
		select	@PickBin = ltrim(rtrim(DfltPickBin)),
			@PutAwayBin = ltrim(rtrim(DfltPutAwayBin)),
			@RepairBin = ltrim(rtrim(DfltRepairBin)),
			@VendorBin = ltrim(rtrim(DfltVendorBin))
		from	ItemSite (NOLOCK)
		where	InvtID = @InvtID
		and	SiteID = @SiteID
	end

	--If the key data exists and either of the bins that can come from the next location are blank
	if @InvtID <> '' and @CpnyID <> '' and (@PickBin = '' or @PutAwayBin = '' or @DfltSiteID = '')
	begin
		--Lookup the bins from INDfltSites
		select	@PickBin = case when @PickBin = '' then ltrim(rtrim(DfltPickBin)) else @PickBin end,
			@PutAwayBin = case when @PutAwayBin = '' then ltrim(rtrim(DfltPutAwayBin)) else @PutAwayBin end,
			@DfltSiteID = case when @DfltSiteID = '' then ltrim(rtrim(DfltSiteID)) else @DfltSiteID end
		from	InDfltSites (NOLOCK)
		where	InvtID = @InvtID
		and	CpnyID = @CpnyID
		and	(DfltSiteID = @DfltSiteID or @DfltSiteID = '')
	end

	--If the key data exists and either of the bins that can come from the next location are blank
	if @ClassID <> '' and @CpnyID <> '' and (@PickBin = '' or @PutAwayBin = '' or @DfltSiteID = '')
	begin
		--Lookup the bins from INProdClDfltSites
		select	@PickBin = case when @PickBin = '' then ltrim(rtrim(DfltPickBin))else @PickBin end,
			@PutAwayBin = case when @PutAwayBin = '' then ltrim(rtrim(DfltPutAwayBin)) else @PutAwayBin end,
			@DfltSiteID = case when @DfltSiteID = '' then ltrim(rtrim(DfltSiteID)) else @DfltSiteID end
		from	INProdClDfltSites (NOLOCK)
		where	ClassID = @ClassID
	   	and	CpnyID = @CpnyID
		and	(DfltSiteID = @DfltSiteID or @DfltSiteID = '')
	end

	--If the key data exists and either of the bins that can come from the next location are blank
	if @CpnyID <> '' and @SiteID <> '' and (@RepairBin = '' or @VendorBin = '')
	begin
		--Lookup the bins from Site
		select	@RepairBin = case when @RepairBin = '' then ltrim(rtrim(DfltRepairBin))else @RepairBin end,
			@VendorBin = case when @VendorBin = '' then ltrim(rtrim(DfltVendorBin)) else @VendorBin end
		from	Site (NOLOCK)
		where	CpnyID = @CpnyID
	   	and	SiteID = @SiteID
	end

	--If the key data exists and either of the bins that can come from the next location are blank
	if @CpnyID <> '' and (@PickBin = '' or @PutAwayBin = '' or @DfltSiteID = '')
	begin
		--Lookup the bins from INCpnyDfltSites
		select	@PickBin = case when @PickBin = '' then ltrim(rtrim(DfltPickBin))else @PickBin end,
			@PutAwayBin = case when @PutAwayBin = '' then ltrim(rtrim(DfltPutAwayBin)) else @PutAwayBin end,
			@DfltSiteID = case when @DfltSiteID = '' then ltrim(rtrim(DfltSiteID)) else @DfltSiteID end
		from	INCpnyDfltSites (NOLOCK)
		where	CpnyID = @CpnyID
		and	(DfltSiteID = @DfltSiteID or @DfltSiteID = '')
	end

	--select @SiteID, @PickBin, @PutAwayBin, @RepairBin, @VendorBin

	return 1	--Always considered successful



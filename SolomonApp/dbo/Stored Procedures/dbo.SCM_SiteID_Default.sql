 create procedure SCM_SiteID_Default
	@CpnyID varchar(10),
	@InvtID varchar(30),
	@ClassID varchar(6),
	@SiteID varchar(10) OUTPUT
as
	--Return a blank site id if no company is passed
	if @CpnyID = ''
	begin
		set @SiteID = ''
		return 1
	end

	--If a site id is passed, pass it back as the default
	if @SiteID = ''
	begin
		--Lookup the default site id from INDfltSites
		select	@SiteID = ltrim(rtrim(DfltSiteID))
		from	INDfltSites (NOLOCK)
		where	InvtID = @InvtID
		and	CpnyID = @CpnyID

		--If a record was not found from above or the Site ID was blank
		if @@ROWCOUNT = 0 or @SiteID = ''
		begin
			--Lookup the default site id from INProdClDfltSites
			select	@SiteID = ltrim(rtrim(DfltSiteID))
			from	INProdClDfltSites (NOLOCK)
			where	ClassID = @ClassID
	   		and	CpnyID = @CpnyID

			--If a record was not found from above or the Site ID was blank
			if @@ROWCOUNT = 0 or @SiteID = ''
			begin
				--Lookup the default site id from INCpnyDfltSites
				select	@SiteID = ltrim(rtrim(DfltSiteID))
				from	INCpnyDfltSites (NOLOCK)
				where	CpnyID = @CpnyID
			end
		end
	end

	--select @SiteID

	return 1	--Always considered successful



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_SiteID_Default] TO [MSDSL]
    AS [dbo];


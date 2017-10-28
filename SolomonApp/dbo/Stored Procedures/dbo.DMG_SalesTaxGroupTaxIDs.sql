 create procedure DMG_SalesTaxGroupTaxIDs
	@GroupID	varchar(10),
	@TaxID01	varchar(10) OUTPUT,
	@TaxID02	varchar(10) OUTPUT,
	@TaxID03	varchar(10) OUTPUT,
	@TaxID04	varchar(10) OUTPUT
as
	declare @TaxID	varchar(10)

	set @TaxID01 = ''
	set @TaxID02 = ''
	set @TaxID03 = ''
	set @TaxID04 = ''

	declare TempCursor cursor fast_forward for
		select	s.TaxID
		from	SalesTax s (NOLOCK)
		join	SlsTaxGrp (NOLOCK) on SlsTaxGrp.TaxID = s.TaxID
		where	SlsTaxGrp.GroupID = @GroupID
		and	TaxType = 'T'

	open TempCursor
	fetch next from TempCursor into @TaxID

	while (@@fetch_status = 0)
	begin
		if @TaxID01 = ''
			set @TaxID01 = ltrim(rtrim(@TaxID))
		else if @TaxID02 = ''
			set @TaxID02 = ltrim(rtrim(@TaxID))
		else if @TaxID03 = ''
			set @TaxID03 = ltrim(rtrim(@TaxID))
		else
			set @TaxID04 = ltrim(rtrim(@TaxID))

		fetch next from TempCursor into @TaxID
	end

	close TempCursor
	deallocate TempCursor

	if @TaxID01 = ''
		return 0	--Failure
	else
		return 1	--Success



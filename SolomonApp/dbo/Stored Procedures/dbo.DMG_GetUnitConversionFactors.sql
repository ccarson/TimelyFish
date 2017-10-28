 create procedure DMG_GetUnitConversionFactors
	@InvtID		varchar(30),
	@ClassID	varchar(6),
	@FromUnit	varchar(6),
	@ToUnit		varchar(6),
	@CnvFact	float OUTPUT,
	@MultDiv	varchar(1) OUTPUT

as
	declare @RowCount	smallint

	-- Check Inventory Item unit definitions
	select	@CnvFact = CnvFact,
		@MultDiv = MultDiv
	from	INUnit (NOLOCK)
	where	UnitType = '3'
	and	InvtID = @InvtID
	and	FromUnit = @FromUnit
	and	ToUnit = @ToUnit

	set @RowCount = @@ROWCOUNT

	-- If Inventory Item unit definitions don't exist
	if @RowCount = 0
	begin
		-- Check Class ID unit definitions
		select	@CnvFact = CnvFact,
			@MultDiv = MultDiv
		from	INUnit (NOLOCK)
		where	UnitType = '2'
		and	ClassID = @ClassID
		and	FromUnit = @FromUnit
		and	ToUnit = @ToUnit

		set @RowCount = @@ROWCOUNT

		-- If the Class ID unit definitions don't exist
		if @RowCount = 0
		begin
			-- Check global unit definitions
			select	@CnvFact = CnvFact,
				@MultDiv = MultDiv
			from	INUnit (NOLOCK)
			where	UnitType = '1'
			and	FromUnit = @FromUnit
			and	ToUnit = @ToUnit

			set @RowCount = @@ROWCOUNT
		end
	end

	-- Return the factors if they were found
	if @RowCount > 0
	begin
		--select @CnvFact, @MultDiv
		return 1	-- Success
	end

	-- If they were not found then try reversing the
	-- from and to units and doing the searches again

	-- Check Inventory Item unit definitions
	select	@CnvFact = CnvFact,
		@MultDiv = MultDiv
	from	INUnit (NOLOCK)
	where	UnitType = '3'
	and	InvtID = @InvtID
	and	FromUnit = @ToUnit
	and	ToUnit = @FromUnit

	set @RowCount = @@ROWCOUNT

	-- If Inventory Item unit definitions don't exist
	if @RowCount = 0
	begin
		-- Check Class ID unit definitions
		select	@CnvFact = CnvFact,
			@MultDiv = MultDiv
		from	INUnit (NOLOCK)
		where	UnitType = '2'
		and	ClassID = @ClassID
		and	FromUnit = @ToUnit
		and	ToUnit = @FromUnit

		set @RowCount = @@ROWCOUNT

		-- If the Class ID unit definitions don't exist
		if @RowCount = 0
		begin
			-- Check Global unit definitions
			select	@CnvFact = CnvFact,
				@MultDiv = MultDiv
			from	INUnit (NOLOCK)
			where	UnitType = '1'
			and	FromUnit = @ToUnit
			and	ToUnit = @FromUnit

			set @RowCount = @@ROWCOUNT
		end
	end

	-- Return the factors if they were found
	if @RowCount > 0
	begin
		-- Need to reverse the MultDiv flag since we did a reverse search
		if @MultDiv = 'M'
			set @MultDiv = 'D'
		else
			set @MultDiv = 'M'

		--select @CnvFact, @MultDiv
		return 1	-- Success
	end
	else
	begin
		--select @CnvFact, @MultDiv
		return 0	-- Failure
	end



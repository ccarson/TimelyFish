 CREATE PROCEDURE DMG_NextOrdNbr

	@CpnyID varchar(10),
	@SOTypeID varchar(4),
	@CustID varchar(15),
	@DocDate smalldatetime,
	@SlsperID varchar(10),
	@UserID varchar(50),
	@OrdNbr varchar(15) OUTPUT

as
	declare @Count		smallint
	declare @DocDateStr	varchar(6)
	declare @Dummy		varchar(10)
	declare @MaxOrdNbr	varchar(10)
	declare @NewOrdNbr	integer
	declare @NewOrdNbrStr	varchar(10)
	declare @OrdNbrPrefix	varchar(15)
	declare @OrdNbrLen	smallint
	declare @OrdNbrMaxLen	smallint
	declare @OrdNbrPrefixLen smallint
	declare @OrdNbrType	varchar(4)
	declare @LastOrdNbr	integer
	declare @LastOrdNbrStr	varchar(10)
	declare @NewPrefix	varchar(100)
	declare @SOTypeIDUpdate	varchar(4)
	declare @StartingOrdNbr	integer

	-- The order number is 10 characters maximum
	set @OrdNbrMaxLen = 10

	-- Lookup the order number configuration fields
	select	@OrdNbrPrefix = OrdNbrPrefix,
		@OrdNbrType = OrdNbrType,
		@LastOrdNbrStr = LastOrdNbr
	from	SOType
	where	CpnyID = @CpnyID
	  and	SOTypeID = @SOTypeID

	-- Set the SOTypeID to update
	select @SOTypeIDUpdate = @SOTypeID

	-- Does the SOType record point to another SOType record for its next order number
	if ltrim(rtrim(@OrdNbrType)) <> ''
	begin
		-- Get the last used order number from the SOType record pointed to by
		-- the SOType ID passed in
		select	@LastOrdNbrStr = LastOrdNbr
		from	SOType
		where	CpnyID = @CpnyID
	  	and	SOTypeID = @OrdNbrType

		-- The order number comes from this one so set it as the one to update
		set @SOTypeIDUpdate = @OrdNbrType
	end

	-- Assign a temporary variable for the new prefix
	select @NewPrefix = @OrdNbrPrefix

	-- Calculate the doc date in yymmdd format
	select @DocDateStr =  convert(varchar(6),@docdate,12)

	-- Substitute the customer id for the &cu code
	while charindex('&cu', @NewPrefix) > 0
		select @NewPrefix = replace(@NewPrefix, '&cu', ltrim(rtrim(@CustID)))

	-- Substitute the doc date for the &da code
	while charindex('&da', @NewPrefix) > 0
		select @NewPrefix = replace(@NewPrefix, '&da', @DocDateStr)

	-- Substitute the salesperson id for the &sa code
	while charindex('&sa', @NewPrefix) > 0
		select @NewPrefix = replace(@NewPrefix, '&sa', ltrim(rtrim(@SlsperID)))

	-- Substitute the user id for the &us code
	while charindex('&us', @NewPrefix) > 0
		select @NewPrefix = replace(@NewPrefix, '&us', ltrim(rtrim(@UserID)))

	-- Begin a transaction so the lock on SOType is held during the order number generation
	begin transaction

	-- Reselect the SOType record that will be updated
	select	@Dummy = LastOrdNbr
	from	SOType (UPDLOCK)
	where	CpnyID = @CpnyID
	  and	SOTypeID = @SOTypeIDUpdate

	-- Get the length of the numeric portion of the order number
	set @OrdNbrLen = len(@LastOrdNbrStr)
	if @OrdNbrLen < 3
		select @OrdNbrLen = 3

	-- Set the maximum length of the order number prefix
	set @OrdNbrPrefixLen = @OrdNbrMaxLen - @OrdNbrLen

	-- Truncate the prefix to the maximum length
	set @NewPrefix = substring(@NewPrefix, 1, @OrdNbrPrefixLen)

	-- Calculate the maximum order number, we roll around to 1 when this number is reached
	set @MaxOrdNbr = replicate('9', @OrdNbrLen)

	-- Increment the last used order number
	set @NewOrdNbr = cast(@LastOrdNbrStr as integer) + 1
	if @NewOrdNbr > @MaxOrdNbr
		set @NewOrdNbr = 1

	-- Set the starting order number so we know when we have looped through all the numbers
	set @StartingOrdNbr = @NewOrdNbr
		-- Calculate a new order number
	set @NewOrdNbrStr = rtrim(@NewPrefix) + replicate('0', @OrdNbrLen - len(cast(@NewOrdNbr as varchar(10)))) + cast(@NewOrdNbr as varchar(10))

	-- Prime the loop
	set @Count = 1

	-- Loop until the new order number is not found
	while @Count <> 0
	begin

		-- See if the order number is being used
		select	@Count = count(*)
		from	SOHeader
		where	CpnyID = @CpnyID
		and	OrdNbr = @NewOrdNbrStr
			-- An existing order was found with the order number
		if @Count <> 0
		begin
			-- Increment the numeric portion of the order number
			set @NewOrdNbr = @NewOrdNbr + 1
			if @NewOrdNbr > @MaxOrdNbr
				set @NewOrdNbr = 1

			-- Calculate a new order number
			set @NewOrdNbrStr = rtrim(@NewPrefix) + replicate('0', @OrdNbrLen - len(cast(@NewOrdNbr as varchar(10)))) + cast(@NewOrdNbr as varchar(10))
		end

		-- If we have looped through all possible order numbers
		if @StartingOrdNbr = @NewOrdNbr
			break
	end

	-- If an existing record with the order number was not found
	if @Count = 0
	begin
		set nocount on

		-- Update the last order number count in the SOType record
		update	SOType
		set	LastOrdNbr = replicate('0', @OrdNbrLen - len(cast(@NewOrdNbr as varchar(10)))) + cast(@NewOrdNbr as varchar(10))
		where	CpnyID = @CpnyID
		and	SOTypeID = @SOTypeIDUpdate

		set nocount off

		commit transaction

		set @OrdNbr = @NewOrdNbrStr

		--select @OrdNbr

		return 1	-- Success
	end
	else
	begin
		rollback transaction

		set @OrdNbr = ''

		--select @OrdNbr

		return 0	-- Failure
	end



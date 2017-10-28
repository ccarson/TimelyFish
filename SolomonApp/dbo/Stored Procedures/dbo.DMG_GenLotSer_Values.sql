 create proc DMG_GenLotSer_Values
	@InvtID varchar(30),
	@Qty float,
	@PrefixDate varchar(12)
as
	declare @LotSerFxdLen smallint
	declare @LotSerFxdTyp varchar(1)
	declare @LotSerFxdVal varchar(12)
	declare @LotSerNumLen smallint
	declare @LotSerNumVal varchar(25)
	declare @LotSerTrack varchar(2)

	declare @MaxSuffix decimal
	declare @SuffixStr varchar(25)
	declare @SuffixValue decimal

	begin transaction

	-- select the values used to generate the lot/serial numbers
	select	@LotSerFxdLen = LotSerFxdLen,
		@LotSerFxdTyp = LotSerFxdTyp,
		@LotSerFxdVal = ltrim(rtrim(LotSerFxdVal)),
		@LotSerNumLen = LotSerNumLen,
		@LotSerNumVal = ltrim(rtrim(LotSerNumVal)),
		@LotSerTrack = ltrim(rtrim(LotSerTrack))
	from	Inventory
	where	InvtID = @InvtID

	-- convert the suffix string into a number
	set @SuffixValue = cast(@LotSerNumVal as int)

	-- calculate the suffix value as a string
	set @SuffixStr = cast(@SuffixValue as varchar(25))

	-- if the LotSerNumVal is blank or the LotSerNumval is less than the defined lenghth., pad the value with 0's
	if Len(@LotSerNumVal) = 0 or Len(@LotSerNumVal) < @LotSerNumLen
		set @LotSerNumVal = replicate('0', @LotSerNumLen - len(@SuffixStr)) + @SuffixStr

	if @LotSerFxdTyp = 'E'
	begin
		rollback
		return(0)
	end

	-- if the prefix is set to Date
	if @LotSerFxdTyp = 'D'
	begin
		set @LotSerFxdLen = len(ltrim(rtrim(@PrefixDate)))
		set @LotSerFxdVal = ltrim(rtrim(@PrefixDate))
	end

	-- if the prefix lengths are not equal
	if @LotSerFxdLen <> len(@LotSerFxdVal) and len(@LotSerFxdVal) <> 0
	begin
		set @LotSerFxdLen = len(@LotSerFxdVal)
	end

	-- if the suffix lengths are not equal
	if @LotSerNumLen <> len(@LotSerNumVal) and len(@LotSerNumVal) <> 0
	begin
		set @LotSerNumLen = len(@LotSerNumVal)
	end

	-- return the lot/serial generation values here before modifying them further
	select	@LotSerFxdLen,
		@LotSerFxdTyp,
		@LotSerFxdVal,
		@LotSerNumLen,
		@LotSerNumVal

	-- make the quantity we need one if the inventory item is not serial controlled
	if @LotSerTrack <> 'SI'
	begin
		set @Qty = 1
	end

	-- calculate the maximum possible suffix value
	set @MaxSuffix = cast(replicate('9', @LotSerNumLen) as int)

	-- Calculate a new suffix value by adding the number of lot or serial
	-- numbers we will be generating to the old suffix value
	set @SuffixValue = @SuffixValue + @Qty

	-- if the suffix value is greater than the maximum it can be
	if @SuffixValue > @MaxSuffix
	begin
		-- loop until the suffix value is less than the maximum suffix value
		while @SuffixValue > @MaxSuffix
		begin
			-- roll the numbers over
			set @SuffixValue = @SuffixValue - (@MaxSuffix - 1)
		end
	end

	select @SuffixValue

	-- calculate the suffix value as a string
	set @SuffixStr = cast(@SuffixValue as varchar(25))

	select @SuffixStr

	set @LotSerNumVal = replicate('0', len(@LotSerNumVal) - len(@SuffixStr)) + @SuffixStr

	-- update the inventory item to the new lot/serial generation values
	update	Inventory
	set	LotSerFxdLen = @LotSerFxdLen,
		LotSerFxdVal = @LotSerFxdVal,
		LotSerNumLen = @LotSerNumLen,
		LotSerNumVal = @LotSerNumVal
	where	InvtID = @InvtID

	commit transaction

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_GenLotSer_Values] TO [MSDSL]
    AS [dbo];


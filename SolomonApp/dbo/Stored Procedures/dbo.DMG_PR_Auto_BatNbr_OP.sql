 CREATE procedure DMG_PR_Auto_BatNbr_OP(
	@CpnyID   	CHAR(10),
	@NumTries 	SMALLINT,
	@Status   	SMALLINT OUTPUT,
	@DocID    	CHAR(10) OUTPUT,
	@Width		SMALLINT OUTPUT
)AS
	DECLARE @Prefix    VARCHAR(30)
	DECLARE @Suffix    VARCHAR(30)
	DECLARE @PrefixLen SMALLINT
	DECLARE @SuffixLen SMALLINT
	DECLARE @Seq       VARCHAR(30)
	DECLARE @Counter   INTEGER
	DECLARE @Done      BIT

	SELECT  @Counter	= 0,
		@Done		= 0,
		@DocID		= '',
		@Prefix		= '',
		@PrefixLen	= 0,
		@Status		= 0,
		@Width		= 0

	-- Loop thru for at most @NumTries times and try to create an unused order nubmer.
	WHILE @Done = 0 AND @Counter < @NumTries BEGIN

		SELECT @Counter = @Counter + 1

		EXEC DMG_PR_Auto_BatNbr_NextNum @Seq OUTPUT, @CpnyID

		IF @Seq = '' BEGIN
	 		-- Return (2 = An error occurred.)
			SET @Status = CONVERT(SMALLINT,2)
			RETURN
		END

		-- Format the suffix
		SELECT @Suffix = LTRIM(RTRIM(@Seq)), @SuffixLen = DATALENGTH(LTRIM(RTRIM(@Seq)))

		-- Put the prefix and sequence number together but chop the prefix to make sure everything fits.
		SELECT @DocID = UPPER( RTRIM( SUBSTRING( @Prefix, 1, DATALENGTH(@DocID) - @SuffixLen ) ) + @Suffix )

		IF NOT EXISTS(SELECT BatNbr FROM Batch (NOLOCK) WHERE Module = 'PO' and BatNbr = @DocID)
			SELECT @Done = 1
	END

	-- If @Done then return success else return
	IF @Done = 1 begin
		-- Return (0 = Success)
		SET @Status = CONVERT(SMALLINT,0)
		SET @Width = @SuffixLen
	end
	ELSE begin
 		-- Return (1 = Tried @NumTries times but didnt find a free number.)
		SET @Status = CONVERT(SMALLINT,1)
		SET @Width = @SuffixLen
	end

	select @Status,@DocID,@Width

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



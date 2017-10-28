
CREATE PROCEDURE DMG_IN_Auto_BatNbr_NextNum(
	@NextNumber Integer OUTPUT
)AS
	DECLARE @INInstalled	SMALLINT
	DECLARE @LastNbr    	VARCHAR(50)
	DECLARE @LastNbrLen 	INTEGER
	DECLARE @NewDecNbr  	DECIMAL
	DECLARE @NewNbr     	VARCHAR(50)
	DECLARE @NewNbrLen  	INTEGER
	DECLARE @Success    	BIT

	select	@INInstalled = count(*)
	from	INSetup (NOLOCK)
	where	Init = 1


	-- IF Inventory is not installed
	if @INInstalled = 0
		Begin
		-- Lock Table
		Update POSetup
			Set LastBatNbr = LastBatNbr  

		-- Grab the last number so we can increment it.
		SELECT  @LastNbr     = LastBatNbr,
				@LastNbrLen  = DATALENGTH(RTRIM(LastBatNbr))
		FROM    POSetup
		End
	else
		Begin
		-- Lock Table
		Update INSetup
			Set LastBatNbr = LastBatNbr  

		-- Grab the last number so we can increment it.
		SELECT  @LastNbr     = LastBatNbr,
				@LastNbrLen  = DATALENGTH(RTRIM(LastBatNbr))
		FROM    INSetup
		End
		
	-- Make sure LastNbrLen is at least length 3
	IF @LastNbrLen < 3
		SELECT @LastNbrLen = 3

	-- We need to get a decimal value from @LastNbr.  If @LastNbr is not a number then
	-- set it to one.
	IF ISNUMERIC(@LastNbr) = 1 BEGIN
		SELECT @NewDecNbr = CONVERT(DECIMAL, @LastNbr) + 1
	END
	ELSE BEGIN
		SELECT @NewDecNbr = 1
	END

	-- Convert the newly incremented number back to a char.
	Set	@NewNbr = Right(Replicate('0', @LastNbrLen) + Cast(@NewDecNbr As VarChar(10)), @LastNbrLen)

	-- Now try to update it.  
	-- If Inventory is not installed
	if @INInstalled = 0
		UPDATE POSetup
		SET    LastBatNbr	= @NewNbr
	else
		UPDATE INSetup
		SET    LastBatNbr	= @NewNbr

	SELECT @NextNumber = @NewDecNbr

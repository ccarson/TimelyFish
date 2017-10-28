 CREATE PROCEDURE DMG_PR_Auto_RcptNbr_NextNum(
	@NextNumber VARCHAR(15) OUTPUT,
	@CpnyID     VARCHAR(10)
)AS
	DECLARE @LastNbr    	VARCHAR(50)
	DECLARE @LastNbrLen 	INTEGER
	DECLARE @NewDecNbr  	DECIMAL
	DECLARE @NewNbr     	VARCHAR(50)
	DECLARE @NewNbrLen  	INTEGER
	DECLARE @tstamp     	TIMESTAMP
	DECLARE @NumTries   	INTEGER
	DECLARE @Success    	BIT
		SELECT 	@NumTries = 0,
		@Success  = 0

	WHILE @Success = 0 AND @NumTries < 100 BEGIN
		SELECT @NumTries = @NumTries + 1

		-- Grab the last number so we can increment it.
		SELECT  @LastNbr     = LastRcptNbr,
			@LastNbrLen  = DATALENGTH(RTRIM(LastRcptNbr)),
			@tstamp      = tstamp
		FROM    POSetup

		-- If no record is found then there is nothing to increment so exit.
		IF @@ROWCOUNT <> 1 BEGIN
			SELECT @NextNumber = '' -- No record was found or more than one.
			RETURN
		END

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
		SELECT @NewNbr = CONVERT(VARCHAR,@NewDecNbr)
		SELECT @NewNbrLen = DATALENGTH(@NewNbr)

		-- If the charvalue is too long, then we need to roll it over back to one.
		IF @NewNbrLen > @LastNbrLen BEGIN
			-- Set the new number to one.
			SELECT @NewNbr = '1'
			SELECT @NewNbrLen = 1
		END

		-- Pad the new number to the desired length.
		SELECT @NewNbr = REPLICATE('0',@LastNbrLen - @NewNbrLen) + @NewNbr

		-- Now try to update it.  The tstamp condition ensures that
		-- we are updating the same row we read earlier.

		set nocount on

		UPDATE POSetup
		SET    LastRcptNbr	= @NewNbr
		WHERE  tstamp		= @tstamp

		-- If the row was updated then we have success
		IF @@ROWCOUNT = 1
			SELECT @Success = 1

		set nocount off
	END

	-- If this call was successful then return the new value.
	IF @Success = 1
		SELECT @NextNumber = @NewNbr
	ELSE
		SELECT @NextNumber = ''

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_PR_Auto_RcptNbr_NextNum] TO [MSDSL]
    AS [dbo];


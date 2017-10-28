 CREATE PROCEDURE ADG_CustNameXRef_Delete

	@CustIDParm varchar(15),
	@NameParm varchar(60)
AS
	
	DECLARE @Name varchar(60)
	DECLARE @NameSeg varchar(20)
	DECLARE @RecExists smallint
	DECLARE @DelimiterPos smallint
	DECLARE @LookupSpecChar varchar(30)

	DECLARE @CharPos smallint
	DECLARE @DelimiterCharPos smallint

	-- Convert to upper case and trim the spaces off
	-- the passed name.
	SELECT @Name = LTRIM(RTRIM(UPPER(@NameParm)))

	-- Skip all of this if no name was passed.
	IF @Name IS NULL
	BEGIN
		RETURN
	END

	SELECT @LookupSpecChar = DfltShpnotInvSub FROM INSetup
	SELECT @LookupSpecChar = LTRIM(RTRIM(@LookupSpecChar)) + ' '

START:
	IF @Name IS NOT NULL
	BEGIN
		SELECT @CharPos = 1

		WHILE 1=1
		BEGIN
			IF @CharPos > DATALENGTH(@Name)
			BEGIN
				SELECT @CharPos = 0
				BREAK
			END

			SELECT @DelimiterCharPos = CHARINDEX(SUBSTRING(@Name, @CharPos, 1), @LookupSpecChar)
			IF @DelimiterCharPos > 0
				BREAK

			SELECT @CharPos = @CharPos + 1
		END
	END
	ELSE
	BEGIN
		SELECT @CharPos = 0
	END

	SELECT @DelimiterPos = @CharPos

	-- If there are not delimiters in the name.
	IF @DelimiterPos = 0
	BEGIN
		-- Assume whats there is a segment.
		SELECT @NameSeg = @Name

		-- If there is something in the name...
		IF @NameSeg IS NOT NULL
		BEGIN
			-- See if the record already exists.
			SELECT @RecExists = COUNT(*) from CustNameXref
			WHERE CustID = @CustIDParm AND NameSeg = @NameSeg

			-- If the record does exist...
			IF @RecExists <> 0
			BEGIN
				-- Delete the segment from the table.
				DELETE FROM CustNameXref
				WHERE CustID = @CustIDParm AND NameSeg =  @NameSeg
			END
		END
		RETURN
	END
	ELSE
	BEGIN
		-- There are delimiters in the name --

		-- Extract the segment.
		SELECT @NameSeg = SUBSTRING(@Name, 1, @DelimiterPos - 1)

		-- If there is something in the name...
		IF @NameSeg IS NOT NULL
		BEGIN

			-- See if the record already exists.
			SELECT @RecExists = COUNT(*) from CustNameXref
			WHERE CustID = @CustIDParm AND NameSeg = @NameSeg

			-- If the record does exist...
			IF @RecExists <> 0
			BEGIN
				-- Delete the segment from the table.
				DELETE FROM CustNameXref
				WHERE CustID = @CustIDParm AND NameSeg =  @NameSeg
			END
		END

		-- Extract the segment from the current name.
		SELECT @Name = LTRIM(SUBSTRING(@Name, @DelimiterPos + 1, 60))
	END

	GOTO START

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



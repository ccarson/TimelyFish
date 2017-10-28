 CREATE PROCEDURE ADG_InvtDescrXref_Add
	@InvtIDParm varchar(30),
	@DescrParm varchar(60)
AS
	DECLARE @Descr varchar(60)
	DECLARE @DescrSeg varchar(20)
	DECLARE @RecExists smallint
	DECLARE @DelimiterPos smallint
	DECLARE @LookupSpecChar varchar(30)
	DECLARE @CharPos smallint
	DECLARE @DelimiterCharPos smallint

	-- Convert to upper case and trim the spaces off
	-- the passed description.
	SELECT @Descr = LTRIM(RTRIM(UPPER(@DescrParm)))

	-- Skip all of this if no description was passed.
	IF @Descr IS NULL
	BEGIN
		RETURN
	END

	SELECT @LookupSpecChar = DfltShpnotInvSub FROM INSetup
	SELECT @LookupSpecChar = LTRIM(RTRIM(@LookupSpecChar)) + ' '

START:
	IF @Descr IS NOT NULL
	BEGIN
		SELECT @CharPos = 1

		WHILE 1=1
		BEGIN
			IF @CharPos > DATALENGTH(@Descr)
			BEGIN
				SELECT @CharPos = 0
				BREAK
			END

			SELECT @DelimiterCharPos = CHARINDEX(SUBSTRING(@Descr, @CharPos, 1), @LookupSpecChar)
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

	-- If there are no delimiters in the description...
	IF @DelimiterPos = 0
	BEGIN
		-- Assume whats there is a segment.
		SELECT @DescrSeg = @Descr

		-- If there is something in the segment...
		IF IsNull(@DescrSeg,'') <> ''
		BEGIN

			-- See if the record already exists.
			SELECT @RecExists = COUNT(*) from InvtDescrXref

			WHERE InvtID = @InvtIDParm AND DescrSeg = @DescrSeg

			-- If the record doesn't exist...
			IF @RecExists = 0
			BEGIN
				/* Add the new segment to the table */
				INSERT INTO InvtDescrXref(Crtd_DateTime, Crtd_Prog, Crtd_User, LUpd_DateTime, LUpd_Prog, LUpd_User,InvtID, DescrSeg)
				VALUES(getdate(), '', '',getdate(), '', '',@InvtIDParm, @DescrSeg)
			END
		END
		RETURN
	END
	ELSE
	BEGIN
		-- There are delimiters in the description --

		-- Extract the segment.
		SELECT @DescrSeg = SUBSTRING(@Descr, 1, @DelimiterPos - 1)

		IF IsNull(@DescrSeg,'') <> ''
		BEGIN
			-- See if the record already exists.
			SELECT @RecExists = COUNT(*) from InvtDescrXref
			WHERE InvtID = @InvtIDParm AND DescrSeg = @DescrSeg

			-- If the record doesn't exist...
			IF @RecExists = 0
			BEGIN
				-- Add the new segment to the table.
				INSERT INTO InvtDescrXref(Crtd_DateTime, Crtd_Prog, Crtd_User, LUpd_DateTime, LUpd_Prog, LUpd_User,InvtID, DescrSeg)
				VALUES(getdate(), '', '',getdate(), '', '',@InvtIDParm, @DescrSeg)
			END
		END

		-- Extract the segment out of the current description.
		SELECT @Descr = LTRIM(SUBSTRING(@Descr, @DelimiterPos + 1, 60))
	END

	GOTO START

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



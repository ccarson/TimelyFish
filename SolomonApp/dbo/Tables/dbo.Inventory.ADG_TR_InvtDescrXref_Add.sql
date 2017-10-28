
CREATE TRIGGER ADG_TR_InvtDescrXref_Add ON dbo.Inventory 
FOR INSERT,UPDATE
AS
	DECLARE @InvtID varchar(30)
	DECLARE @Descr varchar(60)
	DECLARE @TranStatusCode varchar(2)
	DECLARE @RowsAffected int
	DECLARE	@OMInstalled smallint

	SELECT @RowsAffected = @@ROWCOUNT
	SET NOCOUNT ON

	IF @RowsAffected = 1
	BEGIN

		IF UPDATE(Descr)
		BEGIN
			SELECT @InvtID = InvtID, @Descr = Descr from DELETED		
			EXECUTE ADG_InvtDescrXref_Delete @InvtID, @Descr

			SELECT @InvtID = InvtID, @Descr = Descr from INSERTED
			EXECUTE ADG_InvtDescrXref_Add @InvtID, @Descr
		END

		IF UPDATE(TranStatusCode)
		BEGIN
			Select @OMInstalled = count(*) from SOSetup (NOLOCK) 
			IF @OMInstalled > 0 
			BEGIN
				SELECT @InvtID = InvtID, @TranStatusCode = TranStatusCode from INSERTED
				EXECUTE	ADG_ProcessMGr_PlnIn_CrtSh @InvtID, @TranStatusCode
			END
		END
	END

	IF @RowsAffected > 1
	BEGIN

		IF UPDATE(Descr)
		BEGIN

			DECLARE DelCursor SCROLL CURSOR FOR SELECT InvtID, Descr FROM DELETED

			OPEN DelCursor

			FETCH FIRST FROM DelCursor INTO @InvtID, @Descr
			
			WHILE (@@FETCH_STATUS = 0)
			BEGIN
				EXECUTE ADG_InvtDescrXref_Delete @InvtID, @Descr

				FETCH NEXT FROM DelCursor INTO @InvtID, @Descr

			END

			CLOSE DelCursor
			DEALLOCATE DelCursor

			DECLARE InsCursor SCROLL CURSOR FOR SELECT InvtID, Descr FROM INSERTED
	
			OPEN InsCursor
	
			FETCH FIRST FROM InsCursor INTO @InvtID, @Descr
				
			WHILE (@@FETCH_STATUS = 0)
			BEGIN
				EXECUTE ADG_InvtDescrXref_Add @InvtID, @Descr
	
				FETCH NEXT FROM InsCursor INTO @InvtID, @Descr
	
			END
	
			CLOSE InsCursor
			DEALLOCATE InsCursor
		END

		IF UPDATE(TranStatusCode)
		BEGIN
			Select @OMInstalled = count(*) from SOSetup (NOLOCK) 
			IF @OMInstalled > 0 
			BEGIN
				DECLARE InsCursor SCROLL CURSOR FOR SELECT InvtID, TranStatusCode FROM INSERTED
				
				OPEN InsCursor

				FETCH FIRST FROM InsCursor INTO @InvtID, @TranStatusCode
				WHILE (@@FETCH_STATUS = 0)
				BEGIN
					EXECUTE ADG_ProcessMgr_PlnIn_CrtSh @InvtID, @TranStatusCode

					FETCH NEXT FROM InsCursor INTO @InvtID, @TranStatusCode
				END

				CLOSE InsCursor
				DEALLOCATE InsCursor
			END
		END

	END


-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.

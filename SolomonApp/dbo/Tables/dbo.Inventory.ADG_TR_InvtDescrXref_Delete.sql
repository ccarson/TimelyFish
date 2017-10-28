
CREATE TRIGGER ADG_TR_InvtDescrXref_Delete ON dbo.Inventory 
FOR DELETE 
AS
	DECLARE @InvtID varchar(30)
	DECLARE @Descr varchar(60)
	DECLARE @RowsAffected int

	SELECT @RowsAffected = @@ROWCOUNT

	IF @RowsAffected = 1
	BEGIN

		SELECT @InvtID = InvtID, @Descr = Descr from DELETED
		EXECUTE ADG_InvtDescrXref_Delete @InvtID, @Descr
	END

	IF @RowsAffected > 1
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
	END


-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.

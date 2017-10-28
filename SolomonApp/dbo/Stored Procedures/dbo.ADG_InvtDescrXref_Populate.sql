 CREATE PROCEDURE ADG_InvtDescrXref_Populate
AS

	DECLARE @InvtID varchar(30)
	DECLARE @Descr varchar(60)

	TRUNCATE TABLE InvtDescrXref

	DECLARE InvCursor INSENSITIVE CURSOR FOR SELECT InvtID, Descr FROM Inventory

	OPEN InvCursor

	FETCH NEXT FROM InvCursor INTO @InvtID, @Descr

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		EXECUTE ADG_InvtDescrXref_Add @InvtID, @Descr

		FETCH NEXT FROM InvCursor INTO @InvtID, @Descr
	END

	CLOSE InvCursor
	DEALLOCATE InvCursor

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



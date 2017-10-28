
CREATE TRIGGER ADG_TR_CustNameXref_Add ON dbo.Customer 
FOR INSERT,UPDATE
AS
	DECLARE @CustID varchar(15)
	DECLARE @Name varchar(30)
	DECLARE @RowsAffected int

	SELECT @RowsAffected = @@ROWCOUNT

	IF @RowsAffected = 1
	BEGIN

		IF UPDATE(Name)
		BEGIN
			SELECT @CustID = CustID, @Name = Name from DELETED		
			EXECUTE ADG_CustNameXref_Delete @CustID, @Name

			SELECT @CustID = CustID, @Name = Name from INSERTED
			EXECUTE ADG_CustNameXref_Add @CustID, @Name
		END
	END

	IF @RowsAffected > 1
	BEGIN

		IF UPDATE(Name)
		BEGIN

			DECLARE DelCursor SCROLL CURSOR FOR SELECT CustID, Name FROM DELETED

			OPEN DelCursor

			FETCH FIRST FROM DelCursor INTO @CustID, @Name
			
			WHILE (@@FETCH_STATUS = 0)
			BEGIN
				EXECUTE ADG_CustNameXref_Delete @CustID, @Name

				FETCH NEXT FROM DelCursor INTO @CustID, @Name

			END

			CLOSE DelCursor
			DEALLOCATE DelCursor


			DECLARE InsCursor SCROLL CURSOR FOR SELECT CustID, Name FROM INSERTED

			OPEN InsCursor

			FETCH FIRST FROM InsCursor INTO @CustID, @Name
			
			WHILE (@@FETCH_STATUS = 0)
			BEGIN
				EXECUTE ADG_CustNameXref_Add @CustID, @Name
	
				FETCH NEXT FROM InsCursor INTO @CustID, @Name

			END

			CLOSE InsCursor
			DEALLOCATE InsCursor
		END
	END


-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.

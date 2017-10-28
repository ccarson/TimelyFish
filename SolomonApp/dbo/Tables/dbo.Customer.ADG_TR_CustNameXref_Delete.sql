
CREATE TRIGGER ADG_TR_CustNameXref_Delete ON dbo.Customer
FOR DELETE 
AS
	DECLARE @CustID varchar(15)
	DECLARE @Name varchar(30)
	DECLARE @RowsAffected int

	SELECT @RowsAffected = @@ROWCOUNT

	IF @RowsAffected = 1
	BEGIN

		SELECT @CustID = CustID, @Name = Name from DELETED
		EXECUTE ADG_CustNameXref_Delete @CustID, @Name
	END

	IF @RowsAffected > 1
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
	END


-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.

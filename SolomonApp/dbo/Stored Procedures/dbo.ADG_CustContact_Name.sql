 CREATE PROCEDURE ADG_CustContact_Name
	@CustID varchar(15),
	@ContactID varchar(10)
AS
	SELECT Name
	FROM CustContact
	WHERE CustID = @CustID
	AND ContactID = @ContactID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



 CREATE PROCEDURE ADG_Customer_Name
	@parm1 varchar(15)
AS
	SELECT Name
	FROM Customer
	WHERE CustID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



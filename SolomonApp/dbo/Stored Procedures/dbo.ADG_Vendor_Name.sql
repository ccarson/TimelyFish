 CREATE PROCEDURE ADG_Vendor_Name
	@parm1 varchar(15)
AS
	SELECT Name
	FROM Vendor
	WHERE VendID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



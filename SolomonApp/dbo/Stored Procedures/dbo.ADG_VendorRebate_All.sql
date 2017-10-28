 CREATE PROCEDURE ADG_VendorRebate_All
	@CustID varchar(15),
	@InvtID varchar(30),
	@RebateID varchar(10)
AS
	SELECT *
	FROM VendorRebate
	WHERE CustID = @CustID AND
	   	InvtID = @InvtID AND
		RebateID LIKE @RebateID
	ORDER BY RebateID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



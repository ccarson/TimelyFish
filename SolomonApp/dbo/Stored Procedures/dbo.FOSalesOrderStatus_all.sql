 CREATE PROCEDURE FOSalesOrderStatus_all
	@parm1 varchar( 50 )
AS
	SELECT *
	FROM FOSalesOrderStatus
	WHERE SubscriberOrderID LIKE @parm1
	ORDER BY SubscriberOrderID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FOSalesOrderStatus_all] TO [MSDSL]
    AS [dbo];


 CREATE PROCEDURE ADG_Salesperson_All
	@SlsPerId varchar(10)
AS
	SELECT *
	FROM Salesperson
	WHERE SlsperId LIKE @SlsPerId
	ORDER BY SlsperId

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



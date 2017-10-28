 CREATE PROCEDURE ADG_Salesperson_Name
	@parm1 varchar(10)
AS
	SELECT Name
	FROM Salesperson
	WHERE SlsperId = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



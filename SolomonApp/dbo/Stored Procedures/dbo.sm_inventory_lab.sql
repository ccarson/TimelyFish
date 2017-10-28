
CREATE PROCEDURE
	sm_inventory_lab
		@parm1	varchar(30)
AS
	SELECT
		*
	FROM
		inventory
	WHERE
		stkitem = 0
			AND
		InvtType = 'L'
			AND
		invtid LIKE @parm1
	ORDER BY
		invtid

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



 CREATE PROCEDURE
	smSOAddress_CustID_ShipToId
		@parm1	varchar(15)
		,@parm2	varchar(10)
AS
	SELECT
		*
	FROM
		smSoAddress
	WHERE
		CustID LIKE @parm1
			AND
		ShipTOID LIKE @parm2
	ORDER BY
		CustID
		,ShipTOID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



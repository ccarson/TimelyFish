 CREATE PROCEDURE
	smSvcEquipment_Custid_EXE
		@parm1	varchar(15)
		,@parm2	varchar(10)
		,@parm3 varchar(10)
AS
	SELECT
		*
	FROM
		smSvcEquipment With(INDEX (smSvcEquipment1))
	WHERE
		Status = 'A'
			AND
		CustId = @parm1
			AND
		SiteId = @parm2
			AND
		EquipID LIKE @parm3
	ORDER BY
		CustID, SiteID, EquipID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



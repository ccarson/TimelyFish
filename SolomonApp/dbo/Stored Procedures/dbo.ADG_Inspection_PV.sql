 CREATE PROCEDURE ADG_Inspection_PV
	@InvtID varchar(30),
	@InspID	varchar(2)
AS
	SELECT 	InspID, Descr
	FROM 	Inspection
	WHERE 	InvtID like @InvtID
	  AND	InspID like @InspID
	ORDER BY InspID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Inspection_PV] TO [MSDSL]
    AS [dbo];


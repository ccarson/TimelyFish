 CREATE PROCEDURE ADG_ActiveSubAcct_Descr
	@parm1 varchar(24)
AS
       	SELECT 	Descr
	FROM 	Subacct
        WHERE 	Sub = @parm1
	  AND	Active = 1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



 CREATE PROCEDURE EDShipment_PRO
	@parm1 varchar( 30 )
AS
	SELECT *
	FROM EDShipment
	WHERE PRO LIKE @parm1
	ORDER BY PRO

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDShipment_PRO] TO [MSDSL]
    AS [dbo];


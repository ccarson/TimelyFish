 CREATE PROCEDURE CertificationText_all
	@parm1 varchar( 2 )
AS
	SELECT *
	FROM CertificationText
	WHERE CertID LIKE @parm1
	ORDER BY CertID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



 CREATE PROCEDURE ADG_Certification_Descr
	@parm1 varchar(2)
AS
	SELECT Descr
	FROM CertificationText
	WHERE CertID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



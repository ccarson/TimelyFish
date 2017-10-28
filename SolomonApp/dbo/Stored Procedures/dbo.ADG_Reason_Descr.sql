 CREATE PROCEDURE ADG_Reason_Descr
	@parm1 varchar(6)
AS
	SELECT Descr
	FROM ReasonCode
	WHERE ReasonCd = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



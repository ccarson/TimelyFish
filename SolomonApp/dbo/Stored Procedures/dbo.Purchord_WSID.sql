﻿ CREATE PROCEDURE Purchord_WSID @parm1 int
AS
	SELECT *
	FROM Purchord
	WHERE WSID = @parm1
	ORDER BY WSID



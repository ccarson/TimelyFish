﻿ CREATE PROCEDURE Purchord_ASID @parm1 int
AS
	SELECT *
	FROM Purchord
	WHERE ASID = @parm1
	ORDER BY ASID



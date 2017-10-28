 CREATE PROCEDURE
	smSvcCalendar_All_EXE
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smSvcCalendar
	WHERE
		CalendarCode LIKE @parm1
	ORDER BY
		CalendarCode

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



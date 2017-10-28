 CREATE PROCEDURE smServHist_Delete
	@parm1 smallint
AS
	DELETE FROM smServHist
		WHERE WrkRI_ID = @parm1

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



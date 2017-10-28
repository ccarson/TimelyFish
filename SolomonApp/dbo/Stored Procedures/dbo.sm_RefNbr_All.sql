 CREATE PROCEDURE
	sm_RefNbr_All
		@parm1	varchar(10)
AS
  	SELECT
  		*
  	FROM
  		RefNbr
  	WHERE
  		RefNbr LIKE @parm1
    ORDER BY
    	RefNbr DESC

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



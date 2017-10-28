 CREATE PROCEDURE sm_batch_all
	@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		batch
	WHERE
		batnbr LIKE @parm1
	ORDER BY
		batnbr

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



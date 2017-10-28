 CREATE PROCEDURE
	sm_SalesTax_All
		@parm1	varchar(10)
AS
	SELECT
		*
	FROM
		SalesTax
	WHERE
		TaxId LIKE @parm1
	ORDER BY
		TaxId

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



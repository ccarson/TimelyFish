 CREATE PROCEDURE
	smInvoice_DocType_ServCallID
		@parm1	varchar(10)
		,@parm2	varchar(10)
AS
	SELECT
		*
	FROM
		smInvoice
	WHERE
		DocType = 'S'
			AND
		DocumentID = @parm1
			AND
		RefNbr LIKE  @parm2

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



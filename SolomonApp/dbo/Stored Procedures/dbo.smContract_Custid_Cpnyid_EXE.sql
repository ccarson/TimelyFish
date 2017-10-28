 CREATE PROCEDURE
	smContract_Custid_Cpnyid_EXE
		@parm1	varchar(15)
		,@parm2	varchar(10)
		,@parm3 varchar(10)
		,@parm4 varchar(10)
AS
	SELECT
		*
	FROM
		smContract
		WHERE
			CustId = @parm1
				AND
			SiteId = @parm2
				AND
			Cpnyid = @parm3
				AND
			ContractID LIKE @Parm4
	ORDER BY
		CustId
		,SiteId
		,ContractID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smContract_Custid_Cpnyid_EXE] TO [MSDSL]
    AS [dbo];


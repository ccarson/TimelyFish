 CREATE PROCEDURE
	smAgreement_All_NoLock
		@parm1 	varchar(10)
AS
	SELECT
		*
	FROM
		smAgreement (NOLOCK)
	WHERE
		AgreementTypeID LIKE @parm1
	ORDER BY
		AgreementTypeID

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[smAgreement_All_NoLock] TO [MSDSL]
    AS [dbo];


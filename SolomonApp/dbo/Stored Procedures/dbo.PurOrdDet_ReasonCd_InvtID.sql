 CREATE PROCEDURE PurOrdDet_ReasonCd_InvtID
	@parm1 varchar( 6 ),
	@parm2 varchar( 30 )
AS
	SELECT *
	FROM PurOrdDet
	WHERE ReasonCd LIKE @parm1
	   AND InvtID LIKE @parm2
	ORDER BY ReasonCd,
	   InvtID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdDet_ReasonCd_InvtID] TO [MSDSL]
    AS [dbo];


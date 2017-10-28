 CREATE PROCEDURE LCVoucher_CpnyID_APBatNbr_APRe
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM LCVoucher
	WHERE CpnyID LIKE @parm1
	   AND APBatNbr LIKE @parm2
	   AND APRefNbr LIKE @parm3
	ORDER BY CpnyID,
	   APBatNbr,
	   APRefNbr

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LCVoucher_CpnyID_APBatNbr_APRe] TO [MSDSL]
    AS [dbo];


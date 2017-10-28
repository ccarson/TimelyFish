 CREATE PROCEDURE PurOrdLSDet_InvtID_SiteID_LotS
	@parm1 varchar( 30 ),
	@parm2 varchar( 10 ),
	@parm3 varchar( 25 )
AS
	SELECT *
	FROM PurOrdLSDet
	WHERE InvtID LIKE @parm1
	   AND SiteID LIKE @parm2
	   AND LotSerNbr LIKE @parm3
	ORDER BY InvtID,
	   SiteID,
	   LotSerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PurOrdLSDet_InvtID_SiteID_LotS] TO [MSDSL]
    AS [dbo];


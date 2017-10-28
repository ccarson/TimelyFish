 CREATE PROCEDURE SlsPrc_PriceCat_DiscPrcTyp_Sel
	@parm1 varchar( 2 ),
	@parm2 varchar( 1 ),
	@parm3 varchar( 30 ),
	@parm4 varchar( 30 ),
	@parm5 varchar( 4 ),
	@parm6 varchar( 10 )
AS
	SELECT *
	FROM SlsPrc
	WHERE PriceCat LIKE @parm1
	   AND DiscPrcTyp LIKE @parm2
	   AND SelectFld1 LIKE @parm3
	   AND SelectFld2 LIKE @parm4
	   AND CuryID LIKE @parm5
	   AND SiteID LIKE @parm6
	ORDER BY PriceCat,
	   DiscPrcTyp,
	   SelectFld1,
	   SelectFld2,
	   CuryID,
	   SiteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SlsPrc_PriceCat_DiscPrcTyp_Sel] TO [MSDSL]
    AS [dbo];


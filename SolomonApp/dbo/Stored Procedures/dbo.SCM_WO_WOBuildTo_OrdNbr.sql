 CREATE PROC SCM_WO_WOBuildTo_OrdNbr
	@WONbr		varchar ( 16 ),
	@OrdNbr		varchar ( 15 ),
	@LineRef	varchar ( 5 )
AS
	SELECT		*
	FROM		WOBuildTo B LEFT OUTER JOIN WOHeader H
			On H.WONbr = B.WONbr
	WHERE		B.WONbr = @WONbr and
			B.Status = 'P' and		-- Planned Target only
			B.OrdNbr = @OrdNbr and
			B.BuildToLineRef = @LineRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_WO_WOBuildTo_OrdNbr] TO [MSDSL]
    AS [dbo];


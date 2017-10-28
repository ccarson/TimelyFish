
CREATE PROCEDURE [dbo].[pXT121SelectPurOrdDet]
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM PurOrdDet pod
	WHERE pod.User5 LIKE @parm1
	ORDER BY pod.PONbr




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT121SelectPurOrdDet] TO [MSDSL]
    AS [dbo];


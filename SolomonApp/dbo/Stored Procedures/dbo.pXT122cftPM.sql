
CREATE PROCEDURE [dbo].[pXT122cftPM]
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM cftPM
	WHERE PMLoadID LIKE @parm1




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT122cftPM] TO [MSDSL]
    AS [dbo];


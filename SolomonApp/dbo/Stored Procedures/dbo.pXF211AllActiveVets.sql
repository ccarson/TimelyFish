
CREATE PROCEDURE [dbo].[pXF211AllActiveVets] AS 

	SELECT *
	FROM cft_VFDDispatch_Users
	WHERE Status = 'A'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF211AllActiveVets] TO [MSDSL]
    AS [dbo];


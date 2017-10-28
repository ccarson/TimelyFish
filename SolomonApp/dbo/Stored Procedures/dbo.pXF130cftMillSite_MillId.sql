CREATE PROCEDURE pXF130cftMillSite_MillId 
	@parm1 varchar (10) 
	AS 
	SELECT * 
	FROM cftMillSite 
	WHERE MillId = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF130cftMillSite_MillId] TO [MSDSL]
    AS [dbo];


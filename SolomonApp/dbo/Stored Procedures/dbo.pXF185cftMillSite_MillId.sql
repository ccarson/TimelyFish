CREATE PROCEDURE pXF185cftMillSite_MillId 
	@parm1 varchar (6) 
	as 
	SELECT * FROM cftMillSite 
	WHERE MillId = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftMillSite_MillId] TO [MSDSL]
    AS [dbo];


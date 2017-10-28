CREATE PROCEDURE pXF185cftPigGroup_PG 
	@parm1 varchar (10) 
	AS 
	SELECT * 
	FROM cftPigGroup 
	WHERE PigGroupId = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftPigGroup_PG] TO [MSDSL]
    AS [dbo];


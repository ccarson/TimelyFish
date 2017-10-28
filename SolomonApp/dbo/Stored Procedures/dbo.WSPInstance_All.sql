
CREATE PROCEDURE WSPInstance_All @parm1 varchar(60)  
AS  
	SELECT *  
	FROM WSPInstance
	WHERE SLTypeDesc Like @parm1 
	ORDER BY SLTypeDesc

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSPInstance_All] TO [MSDSL]
    AS [dbo];


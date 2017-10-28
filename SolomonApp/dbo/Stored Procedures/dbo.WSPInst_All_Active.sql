CREATE PROCEDURE WSPInst_All_Active @parm1 smallint
AS  
	SELECT *  
	FROM WSPInstance  
	WHERE SLTypeID = @parm1 And Status = "Y"
	ORDER BY SLTypeId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSPInst_All_Active] TO [MSDSL]
    AS [dbo];


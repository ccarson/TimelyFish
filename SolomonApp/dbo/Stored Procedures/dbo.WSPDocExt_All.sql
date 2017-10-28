CREATE PROCEDURE WSPDocExt_All @parm1 smallint, @parm2 varchar(60)
AS  
	SELECT *  
	FROM WSPObjExtension  
	WHERE SLTypeID = @parm1 and SLObjID = @parm2
	ORDER BY SLTypeID 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSPDocExt_All] TO [MSDSL]
    AS [dbo];


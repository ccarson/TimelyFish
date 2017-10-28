CREATE PROCEDURE WSPPubDoc_All_Active @parm1 smallint, @parm2 varchar(60) 
AS  
	SELECT *  
	FROM WSPPubDocLib
	WHERE DocumentID = @parm1 And SLObjId = @parm2 And Status = '1'
	ORDER BY SLTypeId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSPPubDoc_All_Active] TO [MSDSL]
    AS [dbo];


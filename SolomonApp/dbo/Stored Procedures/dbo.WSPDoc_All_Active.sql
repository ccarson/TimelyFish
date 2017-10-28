CREATE PROCEDURE WSPDoc_All_Active @parm1 smallint
AS  
	SELECT *  
	FROM WSPDoc  
	WHERE DocumentID = @parm1 And Active = 1
	ORDER BY DocumentID 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSPDoc_All_Active] TO [MSDSL]
    AS [dbo];



CREATE PROCEDURE WSPDoc_All @parm1 varchar(5), @parm2 varchar(50)
AS  
	SELECT *  
	FROM WSPDoc
	WHERE Instance Like @parm1 And DocumentType Like @parm2
	ORDER BY DocumentType

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSPDoc_All] TO [MSDSL]
    AS [dbo];


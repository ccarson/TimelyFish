
CREATE PROCEDURE 
	Get_UserRec_UserId 
		@parm1 varchar(47)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS
	SELECT 
		*
	FROM 
		vs_UserRec (NOLOCK)
	WHERE	
		UserId LIKE @parm1 
			AND
		RecType = 'U'	
	ORDER BY 
		UserId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Get_UserRec_UserId] TO [MSDSL]
    AS [dbo];


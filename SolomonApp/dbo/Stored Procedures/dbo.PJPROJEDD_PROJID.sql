 CREATE PROCEDURE PJPROJEDD_PROJID @parm1 varchar(10), @parm2 varchar(2)
AS
	SELECT *
	FROM PJProjEDD
	WHERE Project = @parm1 AND DocType like @parm2
	ORDER BY Project, DocType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJEDD_PROJID] TO [MSDSL]
    AS [dbo];


CREATE PROCEDURE PJProjEDDReceiver_ProjID @parm1 varchar(15), @parm2 varchar(2)  
AS  
	SELECT *  
	FROM PJProjEDDReceiver  
	WHERE Project = @parm1 AND DocType like @parm2  
	ORDER BY Project, DocType 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJProjEDDReceiver_ProjID] TO [MSDSL]
    AS [dbo];


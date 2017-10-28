CREATE PROCEDURE EmpEDD_EmpID @parm1 varchar(15), @parm2 varchar(2)  
AS  
	SELECT *  
	FROM EmpEDD  
	WHERE EmpID = @parm1 AND DocType like @parm2  
	ORDER BY EmpID, DocType  

GO
GRANT CONTROL
    ON OBJECT::[dbo].[EmpEDD_EmpID] TO [MSDSL]
    AS [dbo];



CREATE PROCEDURE VendEDDReceiver_VendID @parm1 varchar(15), @parm2 varchar(2)  
AS  
	SELECT *  
	FROM VendEDDReceiver  
	WHERE VendID = @parm1 AND DocType like @parm2  
	ORDER BY VendID, DocType 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[VendEDDReceiver_VendID] TO [MSDSL]
    AS [dbo];


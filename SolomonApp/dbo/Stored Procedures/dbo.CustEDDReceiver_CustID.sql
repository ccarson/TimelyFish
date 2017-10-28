CREATE PROCEDURE CustEDDReceiver_CustID @parm1 varchar(15), @parm2 varchar(2)  
AS  
	SELECT *  
	FROM CustEDDReceiver  
	WHERE CustID = @parm1 AND DocType like @parm2  
	ORDER BY CustID, DocType 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[CustEDDReceiver_CustID] TO [MSDSL]
    AS [dbo];


CREATE PROCEDURE pXF205cftOrderStatus_Status 
	@parm1 varchar (10) 
	AS 
    	SELECT * 
	FROM cftOrderStatus 
	WHERE Status Like @parm1
	ORDER BY Status

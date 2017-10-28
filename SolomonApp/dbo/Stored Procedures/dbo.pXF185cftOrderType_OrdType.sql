CREATE PROCEDURE pXF185cftOrderType_OrdType 
	@parm1 varchar (2) 
	as 
	SELECT * FROM cftOrderType 
	WHERE OrdType = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftOrderType_OrdType] TO [MSDSL]
    AS [dbo];


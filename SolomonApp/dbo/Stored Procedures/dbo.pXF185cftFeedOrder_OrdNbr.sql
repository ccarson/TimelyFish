CREATE PROCEDURE pXF185cftFeedOrder_OrdNbr 
	@parm1 varchar (10) 
	as 
	SELECT * FROM cftFeedOrder 
	WHERE OrdNbr = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftFeedOrder_OrdNbr] TO [MSDSL]
    AS [dbo];


CREATE PROCEDURE pXF185cftFeedOrder_OpenOrdsBarn 
	@parm1 varchar (6), 
	@parm2 smalldatetime, 
	@parm3 varchar (10) 
	as 
	SELECT * FROM cftFeedOrder 
	WHERE MillId LIKE @parm1 
	AND DateSched <= @parm2 
	AND CpnyId = @parm3
	AND Exists (SELECT * FROM cftOrderStatus WHERE Status = cftFeedOrder.Status AND RelFlg = 1)
	ORDER BY BarnNbr, OrdNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftFeedOrder_OpenOrdsBarn] TO [MSDSL]
    AS [dbo];


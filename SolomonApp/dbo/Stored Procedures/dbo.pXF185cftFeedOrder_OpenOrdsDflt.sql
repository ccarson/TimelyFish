CREATE PROCEDURE pXF185cftFeedOrder_OpenOrdsDflt 
	@parm1 varchar (6), 
	@parm2 smalldatetime, 
	@parm3 varchar(10), 
	@parm4 varchar (6),
	@parm5 varchar(10) 
	as 
	SELECT * FROM cftFeedOrder 
	WHERE MillId LIKE @parm1  
	AND CpnyId = @parm3 
	AND ((ContactID LIKE @parm4 AND DateSched <= @parm2))
	AND Exists (SELECT * FROM cftOrderStatus WHERE Status = cftFeedOrder.Status AND RelFlg = 1)
	ORDER BY OrdNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftFeedOrder_OpenOrdsDflt] TO [MSDSL]
    AS [dbo];


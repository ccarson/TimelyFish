CREATE PROCEDURE pXF185cftFeedOrder_LoadTot 
	@parm1 varchar (6) 
	AS 
	SELECT Sum(CnvFactOrd * QtyOrd) 
	FROM cftFeedOrder 
	WHERE LoadNbr = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185cftFeedOrder_LoadTot] TO [MSDSL]
    AS [dbo];


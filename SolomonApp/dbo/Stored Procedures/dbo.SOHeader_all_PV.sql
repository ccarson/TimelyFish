 CREATE PROCEDURE SOHeader_all_PV
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 )
AS
	SELECT OrdNbr, Status, SOTypeID, OrdDate, CustID, CustOrdNbr, TotMerch, Cancelled
	FROM SOHeader
	WHERE CpnyID = @parm1
	   AND OrdNbr LIKE @parm2
	ORDER BY CpnyID,
	   OrdNbr DESC



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOHeader_all_PV] TO [MSDSL]
    AS [dbo];


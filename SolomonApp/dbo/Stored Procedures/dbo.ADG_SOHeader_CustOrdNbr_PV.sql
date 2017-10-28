 CREATE PROCEDURE ADG_SOHeader_CustOrdNbr_PV
	@CpnyID varchar(10),
	@CustOrdNbr varchar(25)
AS
	SELECT CustOrdNbr, CustID, OrdNbr, OrdDate, SOTypeID, Status, SlsperID
	FROM SOHeader
	WHERE CpnyID = @CpnyID AND
		CustOrdNbr LIKE @CustOrdNbr
	ORDER BY CustOrdNbr, CustID



 CREATE PROCEDURE ADG_PricingHistory_All
	@CustID varchar(15),
	@InvtID varchar(30)
AS
	SELECT	SOLine.CurySlsPrice,
		SOHeader.CustID,
		SOLine.DiscPct,
		SOLine.DiscPrcType,
		SOLine.InvtID,
		SOHeader.OrdDate,
		SOLine.OrdNbr,
		SOLine.QtyOrd,
		SOLine.SlsPrice,
		SOLine.UnitDesc

	FROM	SOHeader (NOLOCK)

	JOIN	SOLine (NOLOCK)
	  ON 	SOLine.CpnyID = SOHeader.CpnyID
	 AND	SOLine.OrdNbr = SOHeader.OrdNbr

	WHERE	CustID = @CustID
	  AND 	InvtID = @InvtID

	ORDER BY OrdDate DESC

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



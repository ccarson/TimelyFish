 CREATE PROCEDURE ADG_CustLkp_SOHeader
	@CpnyID varchar(10),
	@OrdNbr varchar(15),
	@InvcNbr varchar(10),
	@ProjectID varchar(16),
	@CustOrdNbr varchar(15)
AS
	-- The replicates are used to make the data returned match the
	-- buffer that is used in the program.
	if @InvcNbr = '%'
	BEGIN
		SELECT
			SOHeader.CustID,
			Customer.Name,
			Customer.Phone,
			SOShipHeader.InvcNbr,
			SOHeader.OrdNbr,
			SOHeader.CustOrdNbr,
			SOHeader.ProjectID,
			SOHeader.SOTypeID,
			REPLICATE(' ', 10),
			REPLICATE(' ', 24),
			SOHeader.CuryTotOrd,
			SOHeader.OrdDate
		FROM SOHeader
		LEFT JOIN Customer ON Customer.CustID = SOHeader.CustID
		LEFT JOIN SOShipHeader ON SOShipHeader.OrdNbr = SOHeader.OrdNbr
		WHERE SOHeader.CpnyID = @CpnyID AND
			SOHeader.OrdNbr LIKE @OrdNbr AND
			SOHeader.ProjectID LIKE @ProjectID AND
			SOHeader.CustOrdNbr LIKE @CustOrdNbr
		ORDER BY SOHeader.CustID, SOHeader.OrdNbr
	END
	ELSE
	BEGIN
		SELECT
			SOHeader.CustID,
			Customer.Name,
			Customer.Phone,
			SOShipHeader.InvcNbr,
			SOHeader.OrdNbr,
			SOHeader.CustOrdNbr,
			SOHeader.ProjectID,
			SOHeader.SOTypeID,
			REPLICATE(' ', 10),
			REPLICATE(' ', 24),
			SOHeader.CuryTotOrd,
			SOHeader.OrdDate
		FROM SOHeader
		LEFT JOIN Customer ON Customer.CustID = SOHeader.CustID
		LEFT JOIN SOShipHeader ON SOShipHeader.OrdNbr = SOHeader.OrdNbr
		WHERE SOHeader.CpnyID = @CpnyID AND
			SOHeader.OrdNbr LIKE @OrdNbr AND
			SOShipHeader.InvcNbr LIKE @InvcNbr AND
			SOHeader.ProjectID LIKE @ProjectID AND
			SOHeader.CustOrdNbr LIKE @CustOrdNbr
		ORDER BY SOHeader.CustID, SOHeader.OrdNbr
	END

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



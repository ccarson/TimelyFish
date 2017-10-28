 CREATE PROCEDURE ADG_CustLkp_ARDoc

	@CpnyID varchar(10),
	@RefNbr varchar(10),
	@PerEnt varchar(6),
	@ProjectID varchar(16),
	@CustOrdNbr varchar(25)
AS
	-- The Converts are used to make sure the data that is
	-- returned match the buffer that is used in the program.
	SELECT
		ARDoc.CustID,
		Customer.Name,
		Customer.Phone,
		CONVERT(varchar(15), RefNbr),
		CONVERT(varchar(15), OrdNbr),
		CONVERT(varchar(25), CustOrdNbr),
		ProjectID,
		CONVERT(varchar(4), DocType),
		BankAcct,
		BankSub,
		CuryOrigDocAmt,
		DocDate
	FROM ARDoc
	LEFT JOIN Customer ON Customer.CustID = ARDoc.CustID
	WHERE CpnyID = @CpnyID AND
		RefNbr LIKE @RefNbr AND
		PerEnt > @PerEnt AND
		ProjectID LIKE @ProjectID AND
		CustOrdNbr LIKE @CustOrdNbr
	ORDER BY ARDoc.CustID, RefNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



 CREATE PROCEDURE ADG_SalesTax_PV
	@TaxID varchar(10)
AS
	SELECT	TaxID,
		Descr,
		TaxType,
		TaxRate
	FROM SalesTax
	WHERE TaxID LIKE @TaxID
	ORDER BY TaxID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



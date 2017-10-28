 CREATE PROCEDURE ADG_SalesTax_Descr
	@TaxID varchar(10)
AS
	SELECT Descr
	FROM SalesTax
	WHERE TaxID = @TaxID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



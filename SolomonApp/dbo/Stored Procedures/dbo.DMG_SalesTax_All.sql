 create procedure DMG_SalesTax_All

	@TaxID varchar(10)
as
	select	*
	from	SalesTax
	where	TaxID like @TaxID
	and	TaxType in ('G','T')
	order by TaxID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



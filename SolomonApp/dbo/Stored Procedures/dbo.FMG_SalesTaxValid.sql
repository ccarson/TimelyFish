 create procedure FMG_SalesTaxValid
	@TaxID	varchar(10)
as
	if (
	select	count(*)
	from	SalesTax (NOLOCK)
	where	TaxID = @TaxID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



 create procedure FMG_TaxIDIsGroup
	@TaxID	varchar(10)
as
	if (
	select	count(*)
	from	SalesTax (NOLOCK)
	where	TaxID = @TaxID
	and	TaxType = 'G'
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_TaxIDIsGroup] TO [MSDSL]
    AS [dbo];


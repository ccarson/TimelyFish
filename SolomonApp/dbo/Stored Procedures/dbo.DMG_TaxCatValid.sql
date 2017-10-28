 create procedure DMG_TaxCatValid
	@CatID	varchar(10)
as
	if (
	select	count(*)
	from 	SlsTaxCat (NOLOCK)
        where 	CatID = @CatID
	) = 0
 		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_TaxCatValid] TO [MSDSL]
    AS [dbo];


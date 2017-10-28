 create procedure FMG_CustContactValid
	@CustID		varchar(15),
	@Type		varchar(2),
	@ContactID	varchar(10)
as
	if (
	select	count(*)
	from	CustContact (NOLOCK)
	where	CustID = @CustID
	and	Type = @Type
	and	ContactID = @ContactID
	) = 0
		--select 0
		return 0	--Failure
	else
		--select 1
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_CustContactValid] TO [MSDSL]
    AS [dbo];


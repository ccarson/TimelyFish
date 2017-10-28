 create procedure FMG_SOAddress_Fetch
	@CustID		varchar(15)
as
	select	*
	from	SOAddress
	where	CustID = @CustID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_SOAddress_Fetch] TO [MSDSL]
    AS [dbo];


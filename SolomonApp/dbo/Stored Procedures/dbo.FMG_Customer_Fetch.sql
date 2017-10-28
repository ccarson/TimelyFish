 create procedure FMG_Customer_Fetch
	@CustID		varchar(15)
as
	select	*
	from	Customer
	where	CustID = @CustID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_Customer_Fetch] TO [MSDSL]
    AS [dbo];


 create procedure FMG_CustomerEDI_Fetch
	@CustID		varchar(15)
as
	select	*
	from	CustomerEDI
	where	CustID = @CustID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[FMG_CustomerEDI_Fetch] TO [MSDSL]
    AS [dbo];


 create procedure EDSendEDIInvoice
	@CustID varchar(15)
as
	select	count(*)
	from	EDOutBound
	where	CustID = @CustID
	and	Trans IN ('810', '880')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSendEDIInvoice] TO [MSDSL]
    AS [dbo];


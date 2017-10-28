 create procedure EDSendEDIShippingNotice
	@CustID varchar(15)
as
	select	count(*)
	from	EDOutBound
	where	CustID = @CustID
	and	Trans IN ('856', '857')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSendEDIShippingNotice] TO [MSDSL]
    AS [dbo];


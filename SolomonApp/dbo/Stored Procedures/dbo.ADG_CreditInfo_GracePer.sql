 create proc ADG_CreditInfo_GracePer
	@CustID	varchar(15)
as
	select	GracePer
	from	CustomerEDI (nolock)
	where	CustID = @CustID



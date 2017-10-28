 create proc ADG_CreditInfo_CreditRule
	@CustID	varchar(15)
as
	select	CreditRule
	from	CustomerEDI (nolock)
	where	CustID = @CustID



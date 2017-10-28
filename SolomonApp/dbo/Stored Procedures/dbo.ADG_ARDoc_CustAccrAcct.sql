 create proc ADG_ARDoc_CustAccrAcct
	@CustID	varchar(15)
as
	select	AccrRevAcct,
		AccrRevSub
	from	Customer
	where	CustID = @CustID



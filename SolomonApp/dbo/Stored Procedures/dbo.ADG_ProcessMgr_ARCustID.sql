 create proc ADG_ProcessMgr_ARCustID
as
	select		ar.CpnyID,
			ar.CustID
	from		ARDoc ar
	join		CustomerEDI ca
	on		ca.CustID = ar.CustID
	where		ca.CreditRule = 'B'
	group by	ar.CpnyID,
			ar.CustID



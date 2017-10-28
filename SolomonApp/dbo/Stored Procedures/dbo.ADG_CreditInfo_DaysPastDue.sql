 create proc ADG_CreditInfo_DaysPastDue
	@CpnyID		varchar(10),
	@CustID		varchar(15),
	@DS4DueDate	varchar(10)
as

	--Convert DS4DueDate (MM/DD/YYYY) to SmallDateTime
	declare @DueDate smalldatetime
	set @DueDate = convert(smalldatetime, @DS4DueDate, 101)

	select	ar.DueDate, ar.RefNbr
	from	ARDoc ar (nolock)
	join	Terms t (nolock)
	on	t.TermsID = ar.Terms

	where	ar.CustID = @CustID
	and	ar.Rlsed = 1
	and	ar.DocType not in ('CM', 'DA', 'PA')
	and	ar.DueDate < @DueDate
	and	ar.DocBal > 0
--	and	ar.CpnyID = @CpnyID
	and	t.CreditChk = 1

	order by
		ar.DueDate, ar.RefNbr



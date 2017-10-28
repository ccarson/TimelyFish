 create proc DMG_CreditInfo_DaysPastDue
	@CpnyID		varchar(10),
	@CustID		varchar(15),
	@DueDate	smalldatetime,
	@ARDueDate	smalldatetime OUTPUT,
	@ARRefNbr	varchar(10) OUTPUT
as
	select	top 1
		@ARDueDate = ar.DueDate,
		@ARRefNbr = ltrim(rtrim(ar.RefNbr))
	from	ARDoc ar (NOLOCK)
	join	Terms t (NOLOCK) on t.TermsID = ar.Terms
	where	ar.CustID = @CustID
	and	ar.Rlsed = 1
	and	ar.DocType not in ('CM', 'DA', 'PA')
	and	ar.DueDate < @DueDate
	and	ar.DocBal > 0
	and	t.CreditChk = 1
	order by ar.DueDate, ar.RefNbr

	if @@ROWCOUNT = 0 begin
		set @ARDueDate = getdate()
		set @ARRefNbr = ''
		return 0	--Failure
	end
	else
		--select @ARDueDate, @ARRefNbr
		return 1	--Success



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CreditInfo_DaysPastDue] TO [MSDSL]
    AS [dbo];


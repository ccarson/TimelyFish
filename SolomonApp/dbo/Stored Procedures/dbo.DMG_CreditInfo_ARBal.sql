 create proc DMG_CreditInfo_ARBal
	@CpnyID		varchar(10),
	@CustID		varchar(15),
	@RlsedExcl	smallint,
	@DocBal		decimal(25,9) OUTPUT
as
	declare @DecPl		smallint
	declare @DocBalAdd	decimal(25,9)
	declare @DocBalSub	decimal(25,9)

	set @DocBalAdd = 0
	set @DocBalSub = 0

	--Get the base currency precision
	exec DMG_GetBaseCurrencyPrecision @CpnyID, @DecPl OUTPUT

	-- Get the additions to the AR balance
	select	@DocBalAdd = sum(ar.DocBal)
	from	ARDoc ar (NOLOCK)
	join	Terms t (NOLOCK)
	on	t.TermsID = ar.Terms
	where	ar.CustID = @CustID
	and	ar.Rlsed <> @RlsedExcl
	and	ar.DocBal <> 0
	and	t.CreditChk = 1
	and	ar.DocType not in ('CM', 'DA', 'PA')

	if @DocBalAdd is null
		set @DocBalAdd = 0

	-- Get the substractions to the AR balance
	select	@DocBalSub = sum(ar.DocBal)
	from	ARDoc ar (NOLOCK)
	join	Terms t (NOLOCK) on t.TermsID = ar.Terms
	where	ar.CustID = @CustID
	and	ar.Rlsed <> @RlsedExcl
	and	ar.DocBal <> 0
	and	t.CreditChk = 1
	and	ar.DocType in ('CM', 'DA', 'PA')

	if @DocBalSub is null
		set @DocBalSub = 0

	-- Set the AR balance return value
	set @DocBal = round(@DocBalAdd - @DocBalSub, @DecPl)
	--select @DocBalAdd, @DocBalSub, @DocBal



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CreditInfo_ARBal] TO [MSDSL]
    AS [dbo];


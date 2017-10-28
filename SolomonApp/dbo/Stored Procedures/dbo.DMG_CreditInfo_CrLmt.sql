 create proc DMG_CreditInfo_CrLmt
	@CpnyID varchar(10),
	@CustID	varchar(15),
	@CrLmt	decimal(25,9) OUTPUT
as
	declare @DecPl			smallint

	set @CrLmt = 0

	--Get the base currency precision
	exec DMG_GetBaseCurrencyPrecision @CpnyID, @DecPl OUTPUT

	-- FMG defines a credit limit (CrLmt) of 0 as infinite credit.
	-- This procedure should only be called for Credit Rule 'A' and 'B'.
	-- Credit Rule 'A' - Credit Limit Only
	-- Credit Rule 'B' - Credit Limit + Past Due
	-- Returns an artificially high credit limit when current credit limit of zero.
	-- This additional logic should be removed if FMG redefines this.
	select	@CrLmt = case when CrLmt <= 0 then 999999999999999 else CrLmt end
	from	Customer (NOLOCK)
	where	CustID = @CustID

	set @CrLmt = round(@CrLmt, @DecPl)
	--select @CrLmt



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_CreditInfo_CrLmt] TO [MSDSL]
    AS [dbo];


 create proc ADG_CreditInfo_CrLmt
	@CustID	varchar(15)
as
	-- FMG defines a credit limit (CrLmt) of 0 as infinite credit.
	-- This procedure should only be called for Credit Rule 'A' and 'B'.
	-- Credit Rule 'A' - Credit Limit Only
	-- Credit Rule 'B' - Credit Limit + Past Due
	-- Returns an artificially high credit limit when current credit limit of zero.
	-- This additional logic should be removed if FMG redefines this.
	select	CrLmt =	case
				when CrLmt <= 0
				then 999999999999999
				else CrLmt
			end
	from	Customer (nolock)
	where	CustID = @CustID



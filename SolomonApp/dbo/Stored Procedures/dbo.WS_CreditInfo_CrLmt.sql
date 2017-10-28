 create proc WS_CreditInfo_CrLmt
	@CustID	varchar(15)
as
	-- This procedure should only be called for Credit Rule 'A' and 'B'.
	-- Credit Rule 'A' - Credit Limit Only
	-- Credit Rule 'B' - Credit Limit + Past Due
	SELECT CrLmt 
	  FROM Customer (nolock)
	 WHERE CustID = @CustID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_CreditInfo_CrLmt] TO [MSDSL]
    AS [dbo];



CREATE PROCEDURE XDDBatchAREFT_Multiple_Batch
	@BatNbr		varchar(10)
AS

	SELECT		count(DISTINCT CashAcct + CashSub)
	FROM 		XDDBatchAREFT (nolock)
	WHERE 		BatNbr = @BatNbr
			and rtrim(CashAcct) <> ''
			and rtrim(CashSub) <> ''

 CREATE PROCEDURE LandedCost_Bat_CntLCReceipts
	@BatchNbr		Varchar(10),
	@ReceiptNbr		Varchar(10)
AS
	SELECT	Count(*)
	FROM	LCReceipt
	WHERE	BatNbr 	= @BatchNbr
	AND     RcptNbr LIKE @ReceiptNbr



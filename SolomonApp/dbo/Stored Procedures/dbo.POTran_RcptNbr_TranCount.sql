 CREATE PROCEDURE POTran_RcptNbr_TranCount
	@ReceiptNbr varchar( 10 )
	AS
	SELECT Count(*)
	FROM POTran (NOLOCK)
	WHERE RcptNbr LIKE @ReceiptNbr
	   AND PurchaseType IN ('GI','GP','GS','GN','PI','PS')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTran_RcptNbr_TranCount] TO [MSDSL]
    AS [dbo];


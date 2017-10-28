 CREATE PROCEDURE POTran_RcptNbr_LandedCost
	@ReceiptNbr varchar( 10 ),
	@parm2min smallint, @parm2max smallint
AS
	SELECT *
	FROM POTran
	WHERE RcptNbr LIKE @ReceiptNbr
	   AND POLineNbr BETWEEN @parm2min AND @parm2max
	   AND PurchaseType IN ('GI','GP','GS','GN','PI','PS')
	ORDER BY PONbr,
	   POLineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POTran_RcptNbr_LandedCost] TO [MSDSL]
    AS [dbo];


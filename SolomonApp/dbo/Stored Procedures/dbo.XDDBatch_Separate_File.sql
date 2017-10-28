
CREATE PROCEDURE XDDBatch_Separate_File
	@BatNbr		varchar( 10 )
AS

	Declare	@BatType			varchar( 1 )
	Declare 	@FormatIDeStatus	varchar( 16 )
	
	SELECT 	@BatType = case when EditScrnNbr = '03030' and Rlsed = 0
				then 'M'
				else 'C'
				end
	FROM		Batch (nolock)
	WHERE	BatNbr = @BatNbr
			and Module = 'AP'
	
	SET	@FormatIDeStatus = ''
	-- Manual Check - need to get	
	if @BatType = 'M'
	BEGIN
		-- Unreleased Manual Check Batch
		SELECT	@FormatIDeStatus = DT.FormatID + DT.eStatus
		FROM	aptran T (nolock) LEFT OUTER JOIN APDoc D (nolock)
			ON T.VendID = D.VendID and T.UnitDesc = D.RefNbr and T.CostType = D.DocType LEFT OUTER JOIN XDDDepositor DD (nolock)
			ON T.VendID = DD.VendID and DD.VendCust = 'V' and D.eConfirm = DD.VendAcct LEFT OUTER JOIN XDDTxnType DT (nolock)
			ON DD.FormatID = DT.FormatID and D.eStatus = DT.eStatus
		WHERE	T.Batnbr = @BatNbr
			and T.DrCr = 'S'
			and DT.FilterSeparateFile = 1
	END
	
	else
	
	BEGIN
		SELECT	@FormatIDeStatus = T.FormatID + T.eStatus
		FROM	APAdjust A (nolock) LEFT OUTER JOIN APDoc V (nolock)
			ON A.VendID = V.VendID and A.AdjdRefNbr = V.RefNbr and A.AdjdDocType = V.DocType LEFT OUTER JOIN XDDDepositor D (nolock)
			ON A.VendID = D.VendID and D.VendCust = 'V' and V.eConfirm = D.VendAcct LEFT OUTER JOIN XDDTxnType T (nolock)
			ON D.FormatID = T.FormatID and V.eStatus = T.eStatus
		WHERE	A.AdjBatNbr = @BatNbr
			and T.FilterSeparateFile = 1
	END

	SELECT 	@FormatIDeStatus

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDBatch_Separate_File] TO [MSDSL]
    AS [dbo];


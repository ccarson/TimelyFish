
CREATE PROCEDURE XDDWrkCheckSel_Display_All
   @AccessNbr		smallint,
   @BatNbr		varchar( 10 )

AS

   SELECT	*
   FROM		XDDWrkCheckSel C (nolock) LEFT OUTER JOIN XDDDepositor D (nolock)
		ON C.VendID = D.VendID and D.VendCust = 'V' and C.EBVendAcct = D.VendAcct
   WHERE	C.AccessNbr = @AccessNbr
   		and C.EBBatNbr = @BatNbr
   ORDER BY	C.EBBatNbr DESC, C.VendID, C.EBVendAcct, C.RefNbr


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDWrkCheckSel_Display_All] TO [MSDSL]
    AS [dbo];


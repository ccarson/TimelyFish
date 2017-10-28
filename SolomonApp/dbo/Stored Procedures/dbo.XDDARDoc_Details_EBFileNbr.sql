
CREATE PROCEDURE XDDARDoc_Details_EBFileNbr
   @EBFileNbr		varchar( 6 ),
   @BatNbr		varchar( 10 ),	
   @FileType		varchar( 1 ),		-- Always 'R'
   @Order		varchar( 1 )		-- "I"d, "N"ame

AS

	-- ARDoc unique index: CustId, DocType, RefNbr, BatNbr, BatSeq
   	if @Order = 'I'

	   	SELECT		A.*, B.*, D.*
	   	FROM		XDDEBFile XF (nolock) LEFT OUTER JOIN XDDBatch XB (nolock)
				ON XF.EBFileNbr = XB.EBFileNbr and XF.FileType = XB.FileType LEFT OUTER JOIN ARDoc A (nolock)
	   			ON XB.BatNbr = A.BatNbr LEFT OUTER JOIN XDDBatchAREFT B (nolock) 
	   			ON XB.BatNbr = B.BatNbr and XB.BatSeq = B.BatSeq and XB.BatEFTGrp = B.BatEFTGrp and A.CustID = B.CustID and A.DocType = B.DocType and A.RefNbr = B.RefNbr LEFT OUTER JOIN XDDDepositor D (nolock)
	   			ON A.CustID = D.VendID and D.VendCust = 'C' LEFT OUTER JOIN Customer C (nolock)
	   			ON A.CustID = C.CustID
	   	WHERE		XF.EBFileNbr = @EBFileNbr
	   			and XF.FileType = @FileType
		   		and XB.BatNbr LIKE @BatNbr
 				and B.EFTAmount <> 0 
 	 	ORDER BY 	C.CustID, A.RefNbr

	else

	   	SELECT		A.*, B.*, D.*
	   	FROM		XDDEBFile XF (nolock) LEFT OUTER JOIN XDDBatch XB (nolock)
				ON XF.EBFileNbr = XB.EBFileNbr and XF.FileType = XB.FileType LEFT OUTER JOIN ARDoc A (nolock)
	   			ON XB.BatNbr = A.BatNbr LEFT OUTER JOIN XDDBatchAREFT B (nolock) 
	   			ON XB.BatNbr = B.BatNbr and XB.BatSeq = B.BatSeq and XB.BatEFTGrp = B.BatEFTGrp and A.CustID = B.CustID and A.DocType = B.DocType and A.RefNbr = B.RefNbr LEFT OUTER JOIN XDDDepositor D (nolock)
	   			ON A.CustID = D.VendID and D.VendCust = 'C' LEFT OUTER JOIN Customer C (nolock)
	   			ON A.CustID = C.CustID
	   	WHERE		XF.EBFileNbr = @EBFileNbr
	   			and XF.FileType = @FileType
		   		and XB.BatNbr LIKE @BatNbr
 				and B.EFTAmount <> 0
 	 	ORDER BY 	C.Name, C.CustID, A.RefNbr

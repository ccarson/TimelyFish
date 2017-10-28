
CREATE PROCEDURE XDDAREFTApplic_EFT
	@CustID		varchar( 15 ),
	@DocType	varchar( 2 ),
	@RefNbr		varchar( 10 )
AS
	SELECT		*
	FROM		XDDBatchAREFT E (nolock) LEFT OUTER JOIN Batch B (nolock)
			ON E.BatNbr = B.BatNbr and B.Module = 'AR' LEFT OUTER JOIN XDDBatch X (nolock)
			ON E.BatNbr = X.BatNbr and E.BatSeq = X.BatSeq and E.BatEFTGrp = X.BatEFTGrp
	WHERE		E.CustID = @CustID
			and E.DocType = @DocType
			and E.RefNbr = @RefNbr
			and X.EBFileNbr <> ''
	ORDER BY	E.BatNbr DESC, E.BatSeq DESC, E.BatEFTGrp DESC		

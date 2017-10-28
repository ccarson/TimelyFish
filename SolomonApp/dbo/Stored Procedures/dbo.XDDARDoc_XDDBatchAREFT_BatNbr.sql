
CREATE PROCEDURE XDDARDoc_XDDBatchAREFT_BatNbr
	@BatNbr		varchar( 10 ),
	@BatEFTGrp	smallint
AS
	SELECT		*
	FROM		ARDoc A LEFT OUTER JOIN XDDBatchAREFT B
			ON A.BatNbr = B.BatNbr and A.BatSeq = B.BatSeq and A.RefNbr = B.RefNbr and B.BatEFTGrp = @BatEFTGrp
	WHERE		A.BatNbr = @BatNbr
--			and A.BatSeq = @BatSeq
	ORDER BY	A.RefNbr


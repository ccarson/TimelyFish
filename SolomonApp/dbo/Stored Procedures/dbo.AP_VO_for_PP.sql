 CREATE PROCEDURE AP_VO_for_PP
	@VendId varchar(15),
	@CuryId varchar(4),
	@RefNbr varchar(10)
AS

SELECT	*
FROM	APDoc d
WHERE	d.status='A'
AND	VendID LIKE @VendID and d.RefNbr LIKE @RefNbr and DocType in ('VO','AC')
AND	LTRIM(PrePay_RefNbr) = ''
AND	d.DocBal>0
AND	d.rlsed = 1
AND	d.CuryId LIKE @CuryId
ORDER BY d.RefNbr



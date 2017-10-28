 CREATE PROCEDURE AP_PP_for_VO
	@CuryId varchar(4),
	@VendId varchar(15),
	@RefNbr varchar(10)
AS
SELECT	j.*
FROM	apadjust j
Join apdoc d on j.adjddoctype = d.doctype AND d.refnbr = j.AdjdRefNbr AND j.vendid = d.vendid 
left outer join VS_UnreleasedAPVoidCheck t on j.AdjgAcct = t.Acct and j.Adjgsub = t.sub and j.AdjgRefNbr = t.RefNbr 
WHERE	
CuryId LIKE @CuryId
AND	j.adjddoctype IN ('PP')
AND	j.AdjAmt > 0
AND	d.docbal <> d.origdocamt
AND	j.s4future11 <> 'V'
and t.acct is null
AND	j.vendid = @VendId
AND	j.adjdrefnbr like @RefNbr
ORDER BY j.adjdrefnbr



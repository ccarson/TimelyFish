 CREATE	PROCEDURE pp_DeleteAPDetail @NewestDelPd CHAR(6) AS

DECLARE	@i INTEGER, @j INTEGER

CREATE	TABLE #DeleteAPDoc (BatNbr CHAR(10), RefNbr CHAR(10), DocType CHAR(2), DocClass CHAR(1), Acct CHAR(10), Sub CHAR(24))
IF @@ERROR<>0 RETURN

INSERT	#DeleteAPDoc
SELECT	d.BatNbr, d.RefNbr, d.DocType, d.DocClass, d.Acct, d.Sub
FROM	APDoc d LEFT JOIN APDoc md ON d.S4Future11='VM' AND md.DocType='VM' AND md.RefNbr=d.MasterDocNbr
	AND (md.OpenDoc=1 OR md.Rlsed=0 OR md.Selected=1)
WHERE	d.OpenDoc = 0 AND d.Rlsed = 1 AND d.PerClosed <= @NewestDelPd and d.PerClosed <> '' AND md.RefNbr IS NULL
IF @@ERROR<>0 RETURN

SELECT	@i=2147483647, @j=(SELECT COUNT(*) FROM #DeleteAPDoc)
IF @@ERROR<>0 RETURN

WHILE	@j < @i BEGIN

	SELECT	@i=@j

	---save docs being paid if the paying is not in the delete set
	DELETE	dn
	FROM	#DeleteAPDoc dn INNER JOIN APAdjust j ON j.AdjdRefNbr=dn.RefNbr AND j.AdjdDocType=dn.DocType
		INNER JOIN APDoc d ON d.Acct=j.AdjgAcct AND d.Sub=j.AdjgSub AND d.RefNbr=j.AdjgRefNbr AND d.DocType=j.AdjgDocType
		LEFT JOIN #DeleteAPDoc dc ON dc.Acct=d.Acct AND dc.Sub=d.Sub AND dc.RefNbr=d.RefNbr AND dc.DocType=d.DocType
	WHERE	dc.RefNbr IS NULL
	IF @@ERROR<>0 RETURN

	---save checks if all of the docs they are paying are not in the delete set
	DELETE	dc
	FROM	#DeleteAPDoc dc INNER JOIN APAdjust j ON dc.Acct=j.AdjgAcct AND dc.Sub=j.AdjgSub AND dc.RefNbr=j.AdjgRefNbr AND dc.DocType=j.AdjgDocType
		INNER JOIN APDoc d ON d.RefNbr=j.AdjdRefNbr AND d.DocType=j.AdjdDocType
		LEFT JOIN #DeleteAPDoc dn ON dn.RefNbr=d.RefNbr AND dn.DocType=d.DocType
	WHERE	dn.RefNbr IS NULL
	IF @@ERROR<>0 RETURN

	SELECT	@j=(SELECT COUNT(*) FROM #DeleteAPDoc)
	IF @@ERROR<>0 RETURN

END

BEGIN	TRANSACTION

DELETE	APDoc
FROM	#DeleteAPDoc
WHERE	APDoc.RefNbr=#DeleteAPDoc.RefNbr AND APDoc.DocType=#DeleteAPDoc.DocType
	AND APDoc.Acct=#DeleteAPDoc.Acct AND APDoc.Sub=#DeleteAPDoc.Sub
IF @@ERROR<>0 GOTO Abort

--- delete the aptrans for checks. checks with the same refnbr (different acct/sub)
--- are no longer allowed in the same batch, so we can use batnbr to get the correct recs
DELETE	APTran
FROM	#DeleteAPDoc
WHERE	APTran.BatNbr=#DeleteAPDoc.BatNbr AND APTran.RefNbr=#DeleteAPDoc.RefNbr AND
	APTran.TranType=#DeleteAPDoc.DocType AND #DeleteAPDoc.DocClass='C'
IF @@ERROR<>0 GOTO Abort

DELETE	APTran
FROM	#DeleteAPDoc
WHERE	APTran.RefNbr=#DeleteAPDoc.RefNbr AND APTran.TranType=#DeleteAPDoc.DocType
	AND #DeleteAPDoc.DocClass='N'
IF @@ERROR<>0 GOTO Abort

DELETE	APAdjust
FROM	#DeleteAPDoc
WHERE	APAdjust.AdjgRefNbr=#DeleteAPDoc.RefNbr AND APAdjust.AdjgDocType=#DeleteAPDoc.DocType
	AND APAdjust.AdjgAcct=#DeleteAPDoc.Acct AND APAdjust.AdjgSub=#DeleteAPDoc.Sub
	AND #DeleteAPDoc.DocClass='C'
IF @@ERROR<>0 GOTO Abort

DELETE	APAdjust
FROM	#DeleteAPDoc
WHERE	APAdjust.AdjdRefNbr=#DeleteAPDoc.RefNbr AND APAdjust.AdjdDocType=#DeleteAPDoc.DocType
	AND #DeleteAPDoc.DocClass='N'
IF @@ERROR<>0 GOTO Abort

DELETE	dv
FROM	APDoc dv LEFT JOIN APDoc dm ON dm.MasterDocNbr=dv.RefNbr
WHERE	dv.DocType='VM' AND dv.OpenDoc=0 AND dv.Rlsed=1 AND dv.Selected=0 AND dm.RefNbr IS NULL
IF @@ERROR<>0 GOTO Abort

COMMIT
RETURN

Abort:
ROLLBACK



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_DeleteAPDetail] TO [MSDSL]
    AS [dbo];


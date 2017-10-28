 CREATE	PROCEDURE pp_DeleteARDetail @NewestDelPd CHAR(6) AS

DECLARE	@i		INTEGER
DECLARE	@ErrCode	INTEGER

CREATE TABLE #DeleteARDoc (RefNbr CHAR(10), DocType CHAR(2), CustID CHAR(15))
IF @@ERROR<>0 RETURN

INSERT #DeleteARDoc
SELECT RefNbr, DocType, CustID
  FROM ARDoc
 WHERE DocBal = 0 AND Rlsed = 1 AND PerClosed <= @NewestDelPd and PerClosed <> ''
IF @@ERROR<>0 RETURN

SELECT	@i=1
IF @@ERROR<>0 RETURN

WHILE	@i > 0 BEGIN

	---save docs being paid if the paying is not in the delete set
        DELETE dn
          FROM #DeleteARDoc dn INNER JOIN ARAdjust j
                                  ON j.AdjdRefNbr=dn.RefNbr AND
                                     j.AdjdDocType=dn.DocType AND
                                     j.CustID=dn.CustID
                                LEFT JOIN #DeleteARDoc dp
                                  ON dp.RefNbr=j.AdjgRefNbr AND
                                     dp.DocType=j.AdjgDocType AND
                                     dp.CustID=dn.CustID
         WHERE dp.RefNbr IS NULL
	SELECT @ErrCode=@@ERROR, @i=@@ROWCOUNT
        IF @@ERROR<>0 OR @ErrCode<>0 RETURN

	---save payments if all of the docs they are paying are not in the delete set
          DELETE dp
            FROM #DeleteARDoc dp INNER JOIN ARAdjust j
                                    ON dp.RefNbr=j.AdjgRefNbr AND
                                       dp.DocType=j.AdjgDocType AND
                                       dp.CustID=j.CustID
                                  LEFT JOIN #DeleteARDoc dn
                                    ON dn.RefNbr=j.AdjdRefNbr AND
                                       dn.DocType=j.AdjdDocType AND
                                       dn.CustID=dp.CustID
           WHERE dn.RefNbr IS NULL
          SELECT @ErrCode=@@ERROR, @i=@i+@@ROWCOUNT
	  IF @@ERROR<>0 OR @ErrCode<>0 RETURN

END

BEGIN	TRANSACTION

  DELETE ARDoc
    FROM #DeleteARDoc
   WHERE ARDoc.RefNbr=#DeleteARDoc.RefNbr AND
         ARDoc.DocType=#DeleteARDoc.DocType AND
         ARDoc.CustID=#DeleteARDoc.CustID
  IF @@ERROR<>0 GOTO Abort

  DELETE ARTran
    FROM #DeleteARDoc
   WHERE ARTran.RefNbr=#DeleteARDoc.RefNbr AND
         ARTran.TranType=#DeleteARDoc.DocType AND
         ARTran.CustID=#DeleteARDoc.CustID
  IF @@ERROR<>0 GOTO Abort

  DELETE ARAdjust
    FROM #DeleteARDoc
   WHERE ARAdjust.AdjgRefNbr=#DeleteARDoc.RefNbr AND
         ARAdjust.AdjgDocType=#DeleteARDoc.DocType AND
         ARAdjust.CustID=#DeleteARDoc.CustID
  IF @@ERROR<>0 GOTO Abort

  DELETE ARAdjust
    FROM #DeleteARDoc
   WHERE ARAdjust.AdjdRefNbr=#DeleteARDoc.RefNbr AND
         ARAdjust.AdjdDocType=#DeleteARDoc.DocType AND
         ARAdjust.CustID=#DeleteARDoc.CustID
  IF @@ERROR<>0 GOTO Abort

  DELETE DocTerms
    FROM #DeleteARDoc
   WHERE DocTerms.RefNbr=#DeleteARDoc.RefNbr AND
         DocTerms.DocType=#DeleteARDoc.DocType AND
         #DeleteARDoc.DocType = 'IN'
  IF @@ERROR<>0 GOTO Abort

  DELETE RefNbr
    FROM #DeleteARDoc
   WHERE #DeleteARDoc.DocType IN('IN','CM','DM','CS') AND RefNbr.RefNbr=#DeleteARDoc.RefNbr
  IF @@ERROR<>0 GOTO Abort

COMMIT
GOTO Finish

Abort:
ROLLBACK

Finish:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_DeleteARDetail] TO [MSDSL]
    AS [dbo];


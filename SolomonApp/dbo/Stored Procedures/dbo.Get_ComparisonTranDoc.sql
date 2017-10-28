 Create Procedure Get_ComparisonTranDoc @parm1 varchar ( 10) as

DECLARE @decPl    int

/* Look up the number of decimal places for the base currency of the batch.*/
SELECT @decPl = c.DecPl
FROM   Batch b INNER JOIN Currncy c ON b.CuryID = c.CuryId
WHERE  b.BatNbr = @parm1 AND
       b.Module = 'AR'

SELECT d.BatNbr,
       d.CustID,
       d.DocType,
       d.RefNbr,
       DocAmt = MIN(ROUND(d.CuryOrigDocAmt,@decpl)),
       SumTrans = SUM(ROUND(t.CuryTranAmt,@decpl))
FROM ARdoc d INNER JOIN ARTran t ON d.BatNbr = t.BatNbr AND
                                    d.CustID = t.CustID AND
                                    d.DocType = t.TranType AND
                                    d.RefNbr = t.RefNbr
WHERE d.Batnbr = @parm1
GROUP BY d.batnbr,d.CustID, d.DocType, d.RefNbr
HAVING  SUM(CONVERT(dec(28,3),t.CuryTranAmt)) <> MIN(CONVERT(dec(28,3),d.CuryOrigDocAmt))



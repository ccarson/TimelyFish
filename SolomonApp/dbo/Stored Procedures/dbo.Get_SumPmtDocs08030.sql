 Create Procedure Get_SumPmtDocs08030 @parm1 varchar ( 10), @parm2 varchar ( 15), @parm3 varchar ( 10)
as

DECLARE @decPl    int
DECLARE @BaseDecPl int
DECLARE @BatType VARCHAR(1)

/* Look up the number of decimal places for the base currency of the batch.*/
SELECT @decPl = c.DecPl, @BaseDecpl = c2.DecPl, @BatType = b.BatType
FROM   Batch b INNER JOIN Currncy c
                       ON b.CuryID = c.CuryId
               CROSS JOIN GLSetup g (nolock)
               INNER JOIN Currncy c2
                       ON g.BaseCuryId = c2.Curyid
WHERE  b.BatNbr = @parm1 AND
       b.Module = 'AR'

SELECT CuryOrigSum = SUM(ROUND(curyorigdocamt,@decPl)),
       OrigSum = SUM(ROUND(OrigDocAmt,@BaseDecPl))
  FROM ARDoc
 WHERE BatNbr = @Parm1 AND
       Doctype = 'PA' AND
       @BatType NOT IN ('C','R') AND
       NOT (CustID = @Parm2 AND
            RefNbr = @Parm3)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Get_SumPmtDocs08030] TO [MSDSL]
    AS [dbo];


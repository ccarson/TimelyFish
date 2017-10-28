 Create Procedure Get_SumPmtDocs @parm1 varchar ( 10), @parm2 varchar ( 15),@parm3 varchar ( 2), @parm4 varchar ( 10)
as

DECLARE @decPl    int

/* Look up the number of decimal places for the base currency of the batch.*/
SELECT @decPl = c.DecPl
FROM   Batch b INNER JOIN Currncy c ON b.CuryID = c.CuryId
WHERE  b.BatNbr = @parm1 AND
       b.Module = 'AR'

SELECT CuryOrigSum = SUM(ROUND(curyorigdocamt,@decPl))
FROM ARDoc
WHERE BatNbr = @Parm1 AND
      NOT (CustID = @Parm2 AND
           DocType = @Parm3 AND
           RefNbr = @Parm4)



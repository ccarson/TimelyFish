 Create Procedure Get_SumPmtDocs08050 @parm1 varchar ( 10), @parm2 varchar ( 15), @parm3 varchar ( 10), @parm4 varchar (2)
as

DECLARE @decPl    int
DECLARE @BaseDecPl int

/* Look up the number of decimal places for the base currency of the batch.*/
SELECT @decPl = c.DecPl, @BaseDecpl = c2.DecPl
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
       NOT (CustID = @Parm2 AND
            RefNbr = @Parm3 AND
            Doctype = @Parm4)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Get_SumPmtDocs08050] TO [MSDSL]
    AS [dbo];


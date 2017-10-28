 CREATE Procedure Get_SumPmtDocs08010 @batnbr varchar ( 10), @custdid varchar ( 15), @refnbr varchar ( 10)
as

SELECT CuryOrigSum = SUM(curyorigdocamt),
       OrigSum = SUM(OrigDocAmt)
  FROM ARDoc (nolock)
 WHERE BatNbr = @batnbr AND
       NOT (CustID = @custdid AND
            RefNbr = @refnbr)
       AND doctype IN ('CS','RF')



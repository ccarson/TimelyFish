 CREATE PROC p08030_DisableBankAcct @Custid VARCHAR (15), @Doctype VARCHAR (2), @Refnbr VARCHAR (10) AS
SELECT d.BATNBR,d.ApplBatnbr,d.CUSTID,d.DOCTYPE,d.REFNBR,b.BatType
  FROM ARDoc d JOIN Batch b
                 ON d.Batnbr = b.Batnbr AND b.Module = 'AR'
 WHERE d.CUSTID = @Custid
       AND d.Doctype = @Doctype
       AND d.Refnbr = @Refnbr
       AND (d.Batnbr <> Applbatnbr OR
           (d.Batnbr = d.applbatnbr AND b.BatType = 'C'))



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08030_DisableBankAcct] TO [MSDSL]
    AS [dbo];


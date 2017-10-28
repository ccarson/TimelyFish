 CREATE PROCEDURE pp_20400_Cash_BankRec
@BatNbr CHAR(10)
AS

SELECT t.* FROM CATran t
           INNER JOIN BankRec b ON
                              b.BankAcct = t.BankAcct AND
                              b.BankSub = t.BankSub AND
                              b.CpnyID = t.BankCpnyID AND
                              b.StmtDate >= t.ClearDate

WHERE t.BatNbr = @BatNbr AND
      t.rcnclstatus = 'C'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_20400_Cash_BankRec] TO [MSDSL]
    AS [dbo];


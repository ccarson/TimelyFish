 /****** Object:  Stored Procedure dbo.CA20010CorrectRoundingError    Script Date: 6/19/2001 09:06:33 ******/

create procedure CA20010CorrectRoundingError @batnbr  varchar (10) as

UPDATE  CATran SET
        TranAmt = CASE CATran.DrCr WHEN 'C'
        THEN ROUND(s.TranDrAmt - s.TranCrAmt, s.DecPl)
        ELSE ROUND(s.TranCrAmt - s.TranDrAmt, s.DecPl) END
FROM    (SELECT t.BatNbr, t.BankCpnyID, t.BankAcct, t.BankSub, DecPl = MAX(c.DecPl),
        TranCrAmt = ROUND(SUM(CASE t.DrCr WHEN 'C' THEN t.TranAmt ELSE 0 END), MAX(c.DecPl)),
        TranDrAmt = ROUND(SUM(CASE t.DrCr WHEN 'D' THEN t.TranAmt ELSE 0 END), MAX(c.DecPl))
        FROM CATRan t INNER JOIN GLSetup g ON g.SetupID = 'GL'
        INNER JOIN Currncy c ON c.CuryID = g.BaseCuryID
        WHERE t.BatNbr = @batnbr AND t.EntryID <> 'ZZ'
        GROUP BY t.BatNbr, t.BankCpnyID, t.BankAcct, t.BankSub) s
WHERE   CATran.BatNbr = s.BatNbr
        AND CATran.EntryID = 'ZZ'
        AND CATran.BankCpnyID = s.BankCpnyID
        AND CATran.BankAcct = s.BankAcct
        AND CATran.BankSub = s.BankSub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CA20010CorrectRoundingError] TO [MSDSL]
    AS [dbo];


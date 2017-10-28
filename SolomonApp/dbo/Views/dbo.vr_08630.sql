 

create view vr_08630 as 

SELECT
    ARTran.Acct, ARTran.BatNbr, ARTran.CpnyID, ARTran.CustId, ARTran.DrCr, 
    ARTran.PerEnt, ARTran.PerPost, ARTran.RefNbr, ARTran.Rlsed, ARTran.Sub, 
    ARTran.TranAmt, ARTran.TranDate, ARTran.TranDesc, ARTran.TranType,
    ARTran.CuryID, ARTran.CuryTranAmt, 
    RptCompany.CpnyName, RptCompany.RI_ID,
    ARTran.User1 as TranUser1, ARTran.User2 as TranUser2, ARTran.User3 as TranUser3, ARTran.User4 as TranUser4, 
    ARTran.User5 as TranUser5, ARTran.User6 as TranUser6, ARTran.User7 as TranUser7, ARTran.User8 as TranUser8,
    Batch.Status as BatchStatus    
FROM
    ARTran INNER JOIN RptCompany ON  ARTran.CpnyID = RptCompany.CpnyID 
    INNER Join Batch ON Batch.BatNbr = ARTran.BatNbr AND Batch.Module in ('BI','AR')
WHERE
    ARTran.DrCr <> 'U' AND
    ARTran.Rlsed = 1 AND
    ARTran.TranType <> 'RC'

UNION ALL

SELECT
    Acct = GLTran.OrigAcct, BatNbr = GLTran.OrigBatNbr, CpnyID = GLTran.CpnyID, CustID = GLTran.Id, 
    DrCr = CASE WHEN GLTran.DrAmt <> 0 THEN 'D' ELSE 'C' END, 
    GLTran.PerEnt, GLTran.PerPost, GLTran.RefNbr, GLTran.Rlsed, Sub = GLTran.OrigSub, 
    TranAmt = CASE WHEN GLTran.DrAmt <> 0 THEN GLTran.DrAmt ELSE GLTran.CrAmt  END, 
    GLTran.TranDate, GLTran.TranDesc, GLTran.TranType,
    GlTran.CuryID, 
    CuryTranAmt = CASE WHEN GLTran.CuryDrAmt <> 0 THEN GLTran.CuryDrAmt ELSE GLTran.CuryCrAmt  END, 
    RptCompany.CpnyName, RptCompany.RI_ID,
    GLTran.User1 as TranUser1, GLTran.User2 as TranUser2, GLTran.User3 as TranUser3, GLTran.User4 as TranUser4, 
    GLTran.User5 as TranUser5, GLTran.User6 as TranUser6, GLTran.User7 as TranUser7, GLTran.User8 as TranUser8,
    Batch.Status as BatchStatus    
FROM
    GLTran  INNER JOIN RptCompany ON  GLTran.CpnyID = RptCompany.CpnyID 
    INNER Join Batch ON Batch.BatNbr = GLTran.BatNbr AND Batch.Module = GLTran.Module
WHERE
    GLTran.Module in ('BI','AR') AND
    GLTran.TranType = 'IC'






 

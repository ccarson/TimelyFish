 

create view vr_03820 as 
SELECT distinct 
    Batch.BatNbr, Batch.CpnyID, Batch.EditScrnNbr, Batch.Module, Batch.PerEnt, Batch.PerPost, Batch.Rlsed, Batch.Status,
    RptCompany.CpnyName, r.RI_ID,
    coalesce(d.CpnyID, d1.CpnyID) as DocCpnyID, 
    coalesce(d.DocDate, d1.DocDate) as DocDate, 
    coalesce(d.OrigDocAmt, d1.OrigDocAmt) as OrigDocAmt, 
    coalesce(d.RefNbr, d1.RefNbr) as RefNbr, 
    coalesce(d.Status, d1.Status) as DocStatus, 
    coalesce(d.VendId, d1.VendID) as VendID,
    Batch.User1 as BatchUser1, Batch.User2 as BatchUser2, Batch.User3 as BatchUser3, Batch.User4 as BatchUser4,
    Batch.User5 as BatchUser5, Batch.User6 as BatchUser6, Batch.User7 as BatchUser7, Batch.User8 as BatchUser8,
    d.User1 as APDocUser1, d.User2 as APDocUser2, d.User3 as APDocUser3, d.User4 as APDocUser4, 
    d.User5 as APDocUser5, d.User6 as APDocUser6, d.User7 as APDocUser7, d.User8 as APDocUser8	
FROM Batch 
     INNER JOIN RptRuntime r ON ((Batch.PerPost >= r.BegPerNbr AND Batch.PerPost <= r.EndPerNbr) OR (Batch.PerEnt >= r.BegPerNbr AND Batch.PerEnt <= r.EndPerNbr))
     INNER JOIN RptCompany ON Batch.CpnyID = RptCompany.CpnyID AND r.RI_ID = RptCompany.RI_ID
     LEFT JOIN APDoc d ON d.BatNbr = Batch.BatNbr	
     LEFT JOIN APTran ON Batch.BatNbr = APTran.BatNbr
     LEFT JOIN APDoc d1 ON APTran.RefNbr = d1.RefNbr AND APTran.VendId = d1.VendId AND
        APTran.Acct = d1.Acct AND APTran.Sub = d1.Sub
WHERE
    r.ReportNbr = '03820' AND
    Batch.Module = 'AP' AND
    Batch.Rlsed = 0 AND
    Batch.Status <> 'R' AND
    coalesce(d.Status, d1.Status, '') <> 'V'


 

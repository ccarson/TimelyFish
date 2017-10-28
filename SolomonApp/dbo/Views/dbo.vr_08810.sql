 

/****** Object:  View dbo.vr_08810    Script Date: 9/8/99 10:59:09  ******/
CREATE VIEW vr_08810 AS
SELECT  Acct = t.acct, 
        t.BatNbr, t.CostType, t.CnvFact, t.CuryID, t.JobRate, t.CuryTaxAmt00, t.CuryTaxAmt01, 
        t.CuryTaxAmt02, t.CuryTaxAmt03, t.DrCr, t.ExtRefNbr, t.ProjectID, t.Qty, t.RefNbr,
        Sub = t.sub, 
        t.SiteID, t.TaskID, t.TaxAmt00, t.TaxAmt01, t.TaxAmt02, t.TaxAmt03, t.TaxId00, t.TaxId01, 
        t.TaxId02, t.TaxId03, t.TranAmt, t.TranDesc, t.UnitDesc, t.UnitPrice, t.CuryTranAmt,
        b.CrTot, b.CtrlTot, DocCuryID = d.CuryID, b.CuryDrTot, b.CuryCrTot, b.CuryCtrlTot, 
        t.CuryUnitPrice, d.DIScBal, d.DIScDate, d.BankSub,
        d.DocBal, d.DocDate, DocStatus = d.Status, d.DocType, d.CuryDIScBal, d.CuryDocBal,
        b.DrTot, d.DueDate, b.EditScrnNbr, b.JrnlType, b.NbrCycle, c.CpnyID, d.BankAcct,
        d.CuryOrigDocAmt, d.OrigDocAmt, t.PerEnt, t.PerPost, d.Rlsed, b.Status, 
        d.Terms, d.TxblTot00, d.TxblTot01, d.TxblTot02, d.TxblTot03, d.CustID,
        d.CuryTxblTot00, d.CuryTxblTot01, d.CuryTxblTot02, d.CuryTxblTot03, cRI_ID = c.RI_ID,
        c.CpnyName, PrtUnappPay = 0, customer_name = COALESCE(u.name,' '), t.recordid, t.LineNbr,
       	b.User1 as BatchUser1, b.User2 as BatchUser2, b.User3 as BatchUser3, b.User4 as BatchUser4,
       	b.User5 as BatchUser5, b.User6 as BatchUser6, b.User7 as BatchUser7, b.User8 as BatchUser8,
       	d.User1 as ARDocUser1, d.User2 as ARDocUser2, d.User3 as ARDocUser3, d.User4 as ARDocUser4, 
       	d.User5 as ARDocUser5, d.User6 as ARDocUser6, d.User7 as ARDocUser7, d.User8 as ARDocUser8,         
       	t.User1 as ARTranUser1, t.User2 as ARTranUser2, t.User3 as ARTranUser3, t.User4 as ARTranUser4, 
       	t.User5 as ARTranUser5, t.User6 as ARTranUser6, t.User7 as ARTranUser7, t.User8 as ARTranUser8 
FROM Batch b INNER JOIN Artran t 
                     ON b.batnbr = t.batnbr 
             INNER JOIN ARDoc d 
                     ON d.doctype = t.trantype 
                    AND d.custid = t.custid 
                    AND d.refnbr = t.refnbr
              LEFT JOIN customer u 
                     ON t.custid = u.custid 
             INNER JOIN RptCompany c 
                     ON d.cpnyid = c.cpnyid
WHERE b.module = 'AR'

UNION ALL

SELECT d.BankAcct, d.BatNbr, ' ', 0, d.CuryID, 0, 0, 0, 
        0, 0, 'D', ' ', d.ProjectID, 0, d.RefNbr,
        d.BankSub, ' ', d.TaskID, 0, 0, 0, 0, ' ', ' ', 
        ' ', ' ', d.origdocamt, d.docDesc, ' ', 0, d.Curyorigdocamt,
        b.CrTot, b.CtrlTot, DocCuryID = d.CuryID, b.CuryDrTot, b.CuryCrTot, b.CuryCtrlTot, 0,
        d.DIScBal, d.DIScDate, d.BankSub,
        d.DocBal, d.DocDate, DocStatus = d.Status, d.DocType, d.CuryDIScBal, d.CuryDocBal,
        b.DrTot, d.DueDate, b.EditScrnNbr, b.JrnlType, b.NbrCycle, c.CpnyID, d.BankAcct,
        d.CuryOrigDocAmt, d.OrigDocAmt, d.PerEnt, d.PerPost, d.Rlsed, b.Status, 
        d.Terms, d.TxblTot00, d.TxblTot01, d.TxblTot02, d.TxblTot03, d.CustID,
        d.CuryTxblTot00, d.CuryTxblTot01, d.CuryTxblTot02, d.CuryTxblTot03, cRI_ID = c.RI_ID, 
        c.CpnyName, PrtUnappPay = 1, u.name, t.recordid, t.LineNbr,
       	b.User1 as BatchUser1, b.User2 as BatchUser2, b.User3 as BatchUser3, b.User4 as BatchUser4,
       	b.User5 as BatchUser5, b.User6 as BatchUser6, b.User7 as BatchUser7, b.User8 as BatchUser8,
       	d.User1 as ARDocUser1, d.User2 as ARDocUser2, d.User3 as ARDocUser3, d.User4 as ARDocUser4, 
       	d.User5 as ARDocUser5, d.User6 as ARDocUser6, d.User7 as ARDocUser7, d.User8 as ARDocUser8,         
       	t.User1 as ARTranUser1, t.User2 as ARTranUser2, t.User3 as ARTranUser3, t.User4 as ARTranUser4, 
       	t.User5 as ARTranUser5, t.User6 as ARTranUser6, t.User7 as ARTranUser7, t.User8 as ARTranUser8 
FROM ARDoc d INNER JOIN Batch b 
                     ON b.BatNbr = d.BatNbr 
             INNER JOIN customer u 
                     ON d.custid = u.custid 
              LEFT JOIN artran t 
                     ON t.custid = d.custid
                    AND t.RefNbr = d.RefNbr 
                    AND t.TranType = d.DocType 
             INNER JOIN RptCompany c 
                     ON d.CpnyID = c.CpnyID
WHERE   b.Module = 'AR' 
        AND d.DocType  = 'PA' 
        AND b.editscrnnbr = '08030' 
        AND b.jrnltype = 'AR' 
        AND b.status IN ('B','H')
        AND t.refnbr IS NULL

 

 

CREATE VIEW vr_03810 AS

SELECT t.Acct, b.BatNbr, t.BoxNbr, t.CostType, CuryID = COALESCE(d.CuryID, t.CuryID), t.CuryTaxAmt00, t.CuryTaxAmt01, 
        t.CuryTaxAmt02, t.CuryTaxAmt03, t.DrCr, t.ExtRefNbr, t.ProjectID, t.Qty, RefNbr = COALESCE(d.RefNbr, t.RefNbr),
        t.Sub, t.TaskID, t.TaxAmt00, t.TaxAmt01, t.TaxAmt02, t.TaxAmt03, t.TaxId00, t.TaxId01, 
        t.TaxId02, t.TaxId03, t.TxblAmt00, t.TxblAmt01,t.TxblAmt02, t.TxblAmt03, 
        t.CuryTxblAmt00, t.CuryTxblAmt01,t.CuryTxblAmt02, t.CuryTxblAmt03,  
        t.TranAmt, t.TranDesc, t.UnitDesc, t.UnitPrice, t.CuryTranAmt,
        b.CrTot, b.CtrlTot, b.CpnyId batchcpny, DocCuryID = d.CuryID, b.CuryDrTot, b.CuryCrTot, d.DiscBal, d.Disctkn, d.DiscDate, 
        d.DocBal, d.DocDate, DocStatus = d.Status, d.DocType, d.CuryDiscBal, d.CuryDocBal, d.CuryPmtAmt,
        b.DrTot, d.DueDate, b.EditScrnNbr, d.InvcDate, d.InvcNbr, b.JrnlType, b.NbrCycle, CpnyID=coalesce(d.CpnyID, b.CpnyID),
        d.CuryOrigDocAmt, d.OrigDocAmt, d.PayDate, t.PerEnt, t.PerPost, d.PmtAmt, d.PONbr, b.Rlsed, b.Status, 
        d.Terms, DocTaxId00 = d.Taxid00, DocTaxID01 = d.TaxId01, DocTaxID02 = d.TaxId02, DocTaxId03 = d.TaxId03, 
        d.TaxTot00, d.TaxTot01, d.TaxTot02, d.TaxTot03, d.CuryTaxTot00, D.CuryTaxTot01, d.CuryTaxTot02, d.CuryTaxTot03, 
        d.TxblTot00, d.TxblTot01, d.TxblTot02, d.TxblTot03, d.CuryTxblTot00, d.CuryTxblTot01, d.CuryTxblTot02, d.CuryTxblTot03, 
        VendID = COALESCE(d.VendID, t.VendId), d.Acct APAcct, d.Sub APSub, cRI_ID = c.RI_ID, c.CpnyName,
        Name =  (SELECT v.Name FROM Vendor v WHERE v.VendID = COALESCE(d.VendID, t.VendID)), VoidRecon = (CASE WHEN t.DrCr = "V" THEN "Void Check" ELSE "Reconcile Check" END),
        HoldCheck = CASE 
        WHEN (b.EditScrnNbr = "03030" OR b.EditScrnNbr = "03620") AND (b.Status <> "U" OR b.Status <> "P")
        THEN "Doc Ref Nbr"
        ELSE "Unit" END,
        TranCpnyID = t.Cpnyid,
	mc.RefNbr As mcRefNbr,
	mc.DocType As mcDocType,
	mc.Acct As mcAcct,
	mc.Sub as mcSub,
	d.ApplyAmt as mcAmt,
	d.ApplyDate as mcDate,
       b.User1 as BatchUser1, b.User2 as BatchUser2, b.User3 as BatchUser3, b.User4 as BatchUser4,
       b.User5 as BatchUser5, b.User6 as BatchUser6, b.User7 as BatchUser7, b.User8 as BatchUser8,
       d.User1 as APDocUser1, d.User2 as APDocUser2, d.User3 as APDocUser3, d.User4 as APDocUser4, 
       d.User5 as APDocUser5, d.User6 as APDocUser6, d.User7 as APDocUser7, d.User8 as APDocUser8	
FROM Batch b 
LEFT OUTER JOIN APDoc d ON b.BatNbr = d.BatNbr AND b.Module = "AP"
LEFT OUTER JOIN APTran t ON b.BatNbr = t.BatNbr AND NOT (isnull(d.doctype, '') = 'VC' and isnull(d.status, '') != 'V') AND (d.RefNbr = t.RefNbr OR b.EditScrnNbr = '03060' OR (b.EditScrnNbr = '03040' and b.Rlsed = 0))
INNER JOIN      RptRunTime r ON (COALESCE(d.PerEnt, t.PerEnt) BETWEEN r.BegPerNbr AND r.EndPerNbr) OR
				   (COALESCE(d.PerPost, t.PerPost) BETWEEN r.BegPerNbr AND r.EndPerNbr)
INNER JOIN RptCompany c ON b.CpnyID = c.CpnyID AND r.Ri_id = c.Ri_id
LEFT OUTER JOIN APDoc mc ON mc.BatNbr = d.BatNbr AND mc.InvcNbr = d.RefNbr AND mc.VendID = d.VendID AND mc.DocType = 'VC' AND b.EditScrnNbr IN ('03010', '03020')
WHERE b.EditScrnNbr NOT IN ('03010', '03020') OR ISNULL(d.DocType,'') <> 'VC'


 

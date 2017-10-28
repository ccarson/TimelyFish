 
CREATE VIEW VP_03400_BWTRANS AS

Select distinct tranamt = case when d.DocType = 'VC' then t.TranAmt * -1 else t.TranAmt end, t.vendid, w.UserAddress, t.RecordID
FROM APDoc d, APAdjust j, APTran t, APDoc d2, Vendor v, WrkRelease w
WHERE d.DocType IN ('HC','EP','CK', 'VC', 'ZC') AND d.VendId = v.Vendid AND v.Vend1099 = 1 AND
       j.AdjgRefNbr = d.RefNbr AND j.AdjgDocType = d.DocType AND j.AdjgAcct = d.Acct and j.AdjgSub = d.Sub and j.VendID = d.VendID AND
       t.RefNbr = j.AdjgRefNbr AND  t.trantype = 'BW' AND t.LineNbr < 0 AND
       d2.RefNbr = j.AdjdRefNbr AND d2.DocType = j.AdjdDocType AND 
       w.BatNbr = d.Batnbr AND w.Module = 'AP' AND t.BoxNbr <> ' '


 

CREATE VIEW vp_03400APDocAdjust AS

/****** File Name: 0311vp_03400APDocAdjust					******/
/****** Select/Calculate amounts to be affecting adjusted & adjusting 	******/
/****** document balances & other fields.						******/

/***** Document Balance Adjustment *****/

SELECT j.VendID, w.UserAddress, j.AdjdRefNbr, j.AdjdDocType, CuryDiscAmt = SUM(j.CuryAdjdDiscAmt), 
	CuryAdjAmt = SUM(j.CuryAdjdAmt), AdjDiscAmt = SUM(j.AdjDiscAmt), 
	AdjAmt = SUM(j.AdjAmt), BWAmt = SUM(j.AdjBkupWthld), CuryBWAmt = SUM(j.CuryAdjdbkupwthld), 
	CuryadjBWAmt = SUM(j.CuryAdjdbkupwthld),
        perpost = case when (select max(j1.adjgperpost) from apadjust j1 
			where 
			j1.AdjdRefNbr = j.AdjdRefNbr AND 
			j1.AdjdDocType = j.AdjdDocType AND 
			j1.VendID = j.VendID  and 
			j1.adjgdoctype <> 'VC'   
			and not exists (select 'x' from apadjust j2 
					where j2.adjgdoctype = 'VC' and 
					j1.adjgrefnbr = j2.adjgrefnbr and
					j1.adjgacct = j2.adjgacct and
					j1.adjgsub = j2.adjgsub))> d.perpost then
			(select max(j1.adjgperpost) from apadjust j1 
			where 
			j1.AdjdRefNbr = j.AdjdRefNbr AND 
			j1.AdjdDocType = j.AdjdDocType AND 
			j1.VendID = j.VendID  and 
			j1.adjgdoctype <> 'VC'   
			and not exists (select 'x' from apadjust j2 
					where j2.adjgdoctype = 'VC' and 
					j1.adjgrefnbr = j2.adjgrefnbr and
					j1.adjgacct = j2.adjgacct and
					j1.adjgsub = j2.adjgsub))
			else
			d.perpost
			end,
        d.CpnyID, DrCr = ' ', adjtype = min(j.ADjgDocType), d.Acct, d.Sub
FROM WrkRelease w, APDoc d, APAdjust j 
WHERE w.Module = "AP" AND w.BatNbr = j.AdjBatNbr AND j.AdjdRefNbr = d.RefNbr AND j.AdjdDocType = d.DocType
	AND j.VendID = d.VendID
GROUP BY w.UserAddress, j.VendID, j.AdjdRefNbr, j.AdjdDocType, j.adjgperpost ,d.perpost, d.CpnyID, d.Acct, d.Sub

UNION

/***** Check Reconciliation *****/

SELECT d.VendID, w.UserAddress, d.RefNbr, d.DocType, 0, t.CuryTranAmt, 0, t.TranAmt, 0, 0, 0, 
	t.PerPost, d.CpnyID, "R", adjtype = '', d.Acct, d.Sub
FROM WrkRelease w, APTran t, APDoc d 
WHERE w.Module = "AP" AND  t.BatNbr = w.BatNbr AND t.DrCr = "R" AND t.RefNbr = d.RefNbr AND t.Acct = d.Acct AND 
	t.Sub = d.Sub AND d.DocType IN ("CK", "HC","EP") 

UNION

/***** Void Check *****/

SELECT d.VendID, w.UserAddress, t.RefNbr, d.DocType, 0, 0, 0, 0,0,0,0, t.PerPost, 
	d.CpnyID, "V",adjtype =  '', d.Acct, d.Sub
FROM WrkRelease w, APTran t, APDoc d 
WHERE w.Module = "AP" AND  t.BatNbr = w.BatNbr AND t.DrCr = "V" AND t.RefNbr = d.RefNbr AND 
	t.Acct = d.Acct AND t.Sub = d.Sub AND d.DocType IN ("CK", "HC", "EP", "ZC") 


 


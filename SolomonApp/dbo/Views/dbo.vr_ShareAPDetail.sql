 


CREATE VIEW vr_ShareAPDetail AS

SELECT DISTINCT Parent = CASE 
		WHEN v.Ord = 1 THEN d.RefNbr
		WHEN v.Ord = 2 AND v.CNum = 1 AND j.AdjdDocType <> "AD" THEN j.AdjgRefNbr
		WHEN v.Ord = 2 AND v.CNum = -1 AND j.AdjdDocType = "AD" THEN j.AdjgRefNbr
		ELSE j.AdjdRefNbr END,
	Acct = CASE v.Ord WHEN 1 THEN d.Acct ELSE j.AdjgAcct END,
	CpnyID = CASE v.Ord WHEN 1 THEN d.CpnyID ELSE d.CpnyID END,
	Sub = CASE v.Ord WHEN 1 THEN d.Sub ELSE j.AdjgSub END,
	v.Ord, d.VendID, dStatus = CASE Ord WHEN 1 THEN d.Status ELSE ' ' END, 
	RefNbr = CASE v.Ord WHEN 1 THEN d.RefNbr ELSE j.AdjgRefNbr END,
	DueDate = CASE v.Ord WHEN 1 THEN d.DueDate ELSE j.AdjgDocDate END,
	PayDate = CASE v.Ord WHEN 1 THEN d.PayDate ELSE j.AdjgDocDate END,
	DiscDate = CASE v.Ord WHEN 1 THEN d.DiscDate ELSE j.AdjgDocDate END,
	DocDate = CASE v.Ord WHEN 1 THEN d.DocDate ELSE j.AdjgDocDate END,
	InvcNbr = CASE v.Ord WHEN 1 THEN d.InvcNbr ELSE ' ' END,
	InvcDate = CASE v.Ord WHEN 1 THEN d.InvcDate ELSE ' ' END,
	DocType = CASE v.Ord WHEN 1 THEN d.DocType WHEN 2 THEN j.AdjgDocType WHEN 3 THEN "DT" When 4 Then (CASE When j.AdjBkupWthld <> 0 then "BW" END) END,
      PerEnt = d.PerEnt, MasterDocNbr = d.MasterDocNbr, S4Future11 = d.S4Future11,
	PerPost = CASE v.Ord WHEN 3 THEN j.AdjgPerPost ELSE d.PerPost END,
	PerClosed = CASE v.Ord WHEN 3 THEN j.AdjgPerPost ELSE d.PerClosed END,
	OrigDocAmt = CASE v.Ord 
		WHEN 1 THEN d.OrigDocAmt * (CASE d.DocType WHEN "AD" THEN -1 WHEN "PP" THEN -1 ELSE 1 END)
		WHEN 2 THEN (CASE j.AdjdDocType WHEN "PP" THEN 0 ELSE j.AdjAmt * v.CNum END)
		WHEN 3 THEN j.AdjDiscAmt * (CASE j.AdjdDocType WHEN "AD" THEN 1 WHEN "PP" THEN 1 ELSE -1 END) 
		When 4 Then (CASE When j.AdjBkupWthld <> 0 then j.AdjBkupWthld * -1 END)END,
	DocBal = CASE v.Ord WHEN 1 THEN (CASE d.DocType WHEN "AD" THEN -d.DocBal
                                	WHEN "PP" then isnull((SELECT -sum(j.adjamt) from apadjust j where d.refnbr = j.adjdrefnbr and j.adjddoctype="PP"),0)
			ELSE d.DocBal END) ELSE 0 END,
	CuryOrigDocAmt = CASE v.Ord 
		WHEN 1 THEN d.CuryOrigDocAmt * (CASE d.DocType WHEN "AD" THEN -1 WHEN "PP" THEN -1 ELSE 1 END)
		WHEN 2 THEN (CASE j.AdjdDocType WHEN "PP" THEN 0 ELSE j.CuryAdjdAmt * v.CNum END)
		WHEN 3 THEN j.CuryAdjdDiscAmt * (CASE j.AdjdDocType WHEN "AD" THEN 1 WHEN "PP" THEN 1 ELSE -1 END)
		When 4 Then (CASE When j.AdjBkupWthld <> 0 then j.AdjBkupWthld * -1 END) END,
	CuryDocBal = CASE v.Ord WHEN 1 THEN (CASE d.DocType WHEN "AD" THEN -d.CuryDocBal
                                	WHEN "PP" then isnull((SELECT -sum(j.curyadjdamt) from apadjust j where d.refnbr = j.adjdrefnbr and j.adjddoctype="PP"),0)
			ELSE d.CuryDocBal END) ELSE 0 END,
	CuryID = CASE v.Ord WHEN 1 THEN d.CuryID ELSE j.CuryAdjdCuryID END,
	ParentType = CASE 
		WHEN v.Ord = 1 THEN d.DocType 
		WHEN v.Ord = 2 AND v.CNum = 1 AND j.AdjdDocType <> "AD" THEN j.AdjgDocType
		WHEN v.Ord = 2 AND v.CNum = -1 AND j.AdjdDocType = "AD" THEN j.AdjgDocType
		ELSE j.AdjdDocType END,
       d.User1 as APDocUser1, d.User2 as APDocUser2, d.User3 as APDocUser3, d.User4 as APDocUser4, 
       d.User5 as APDocUser5, d.User6 as APDocUser6, d.User7 as APDocUser7, d.User8 as APDocUser8		
FROM vr_ShareControlDoc32 v, APDoc d LEFT OUTER JOIN APAdjust j ON j.AdjgRefNbr = d.RefNbr AND 
	j.AdjgDocType = d.DocType AND j.AdjgAcct = d.Acct AND j.AdjgSub = d.Sub
WHERE d.Rlsed = 1 AND (
	(v.Ord = 1 AND ((d.DocBal <> 0 and d.DocType <> "VM") OR (d.DocType IN ("VO", "AC", "AD","PP")))) OR
	(v.Ord = 2 AND j.AdjgRefNbr IS NOT NULL ---AND d.RefNbr <> CASE
		) OR
	(v.Ord = 3 AND j.AdjDiscAmt <> 0 AND j.AdjgRefNbr IS NOT NULL) OR (v.Ord = 4 AND j.AdjgRefNbr IS NOT NULL and j.AdjBkupWthld <> 0))


 

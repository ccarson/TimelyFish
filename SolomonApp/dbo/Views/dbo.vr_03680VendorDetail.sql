 


--APPTABLE
--USETHISSYNTAX


/****** Object:  View dbo.vr_03680VendorDetail    Script Date: 5/31/00 3:34:12 PM ******/

CREATE VIEW vr_03680VendorDetail AS

SELECT Parent = d.RefNbr,
	Acct = d.Acct,
	CpnyID = d.CpnyID,
	Sub = d.Sub,
	Ord = 1, d.VendID, dStatus = d.Status, 
	RefNbr = d.RefNbr,
	DueDate = d.DueDate,
	PayDate = d.PayDate,
	DiscDate = d.DiscDate,
	DocDate = d.DocDate,
	InvcNbr = d.InvcNbr,
	InvcDate = d.InvcDate,
	DocType = d.DocType,
      PerEnt = d.PerEnt, MasterDocNbr = d.MasterDocNbr, S4Future11 = d.S4Future11,
	PerPost = d.PerPost,
	PerClosed = d.PerClosed,
	OrigDocAmt = d.OrigDocAmt * (CASE d.DocType WHEN 'AD' THEN -1 WHEN 'PP' THEN -1 ELSE 1 END),
	DocBal = CASE d.DocType WHEN 'AD' THEN -d.DocBal
                                	WHEN 'PP' then isnull((SELECT -sum(j.adjamt) from apadjust j where d.refnbr = j.adjdrefnbr and j.adjddoctype='PP'),0)
			ELSE d.DocBal END,
	CuryOrigDocAmt = d.CuryOrigDocAmt * (CASE d.DocType WHEN 'AD' THEN -1 WHEN 'PP' THEN -1 ELSE 1 END),
	CuryDocBal = CASE d.DocType WHEN 'AD' THEN -d.CuryDocBal
                                	WHEN 'PP' then isnull((SELECT -sum(j.curyadjdamt) from apadjust j where d.refnbr = j.adjdrefnbr and j.adjddoctype='PP'),0)
			ELSE d.CuryDocBal END,
	CuryID = d.CuryID,
	ParentType = d.DocType,
	VName = SUBSTRING(v.Name, 1, 30),
        vStatus = v.Status, APAcct=CASE d.Acct WHEN '' THEN v.APAcct ELSE d.Acct END,
	APSub=CASE d.Sub WHEN '' THEN v.APSub ELSE d.Sub END,
        vCuryID = v.CuryID,
       v.User1 as VendorUser1, v.User2 as VendorUser2, v.User3 as VendorUser3, v.User4 as VendorUser4,
       v.User5 as VendorUser5, v.User6 as VendorUser6, v.User7 as VendorUser7, v.User8 as VendorUser8,
       d.User1 as APDocUser1, d.User2 as APDocUser2, d.User3 as APDocUser3, d.User4 as APDocUser4, 
       d.User5 as APDocUser5, d.User6 as APDocUser6, d.User7 as APDocUser7, d.User8 as APDocUser8

FROM Vendor v INNER JOIN APDoc d ON d.VendID=v.VendID
WHERE d.Rlsed = 1 AND d.DocType NOT IN ('CK','HC','EP','ZC', 'VC', 'VM', 'VT') AND (d.DocBal<>0 OR d.DocType='PP')


 

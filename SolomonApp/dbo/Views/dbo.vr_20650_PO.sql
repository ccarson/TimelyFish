 

create view vr_20650_PO as 
SELECT o.PONbr, 
	d.LineRef, 
	COALESCE(NULLIF(d.PromDate, ''), o.PODate) as PromDate, 
	d.CuryExtCost - d.CuryCostVouched as CuryPOAmt, 
	d.ExtCost - d.CostVouched as POAmt, 
	o.Terms, 
	v.PayDateDflt, 
	t.DiscIntrv, 
	t.disctype, 
	t.DueIntrv, 
	t.duetype, 
	o.VendID, 
	o.CpnyID, 
	case when v.APAcct = '' or v.APSub = '' then s.APAcct else v.APAcct end as Acct, 
	case when v.APAcct = '' or v.APSub = '' then s.APSub else v.APSub end as Sub, 
	o.CuryID
FROM PurchOrd o INNER JOIN PurOrdDet d ON o.PONbr = d.PONbr
	INNER JOIN Vendor v ON v.VendID = o.VendID
	INNER JOIN Terms t ON t.TermsID = o.Terms
	CROSS JOIN APSetup s
WHERE d.CuryExtCost > d.CuryCostVouched
	AND o.Status <> 'M' AND o.Status <> 'X'


 

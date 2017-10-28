CREATE  VIEW cfvInventoryRecon

 AS

	SELECT 	tr.InvtId, tr.SiteID, tr.PerPost,
	Receipts = Sum(CASE tr.TranType
	WHEN 'AJ' Then 0
	ELSE (tr.CnvFact * tr.Qty * tr.InvtMult) END), 
	Adjustments = Sum(CASE tr.TranType
	WHEN 'AJ' Then (tr.Qty*tr.CnvFact * tr.InvtMult)
	ELSE 0 END)
	FROM InTran tr 
	JOIN Inventory invt ON tr.InvtId=invt.INvtId
	JOIN GlSetup gls ON tr.PerPost=gls.PerNbr
	Where (invt.ClassID IN ('CORN','ING','FGM') OR (invt.ClassID='RATION' AND tr.TranType<>'CT')) AND tr.Rlsed='1'
	Group by tr.InvtId, tr.PerPost, tr.SiteID
	



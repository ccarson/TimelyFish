CREATE VIEW cfvCurrentInvTrans

 AS

	SELECT 	tr.SiteID, tr.InvtID, 
	Type = CASE tr.TranType
	WHEN 'AJ' Then 'Adjustment'
	ELSE 'Receipt' END, 
	Sum(tr.Qty) As PerSum 
	FROM InTran tr
	JOIN GlSetup gls ON tr.PerPost=gls.PerNbr
	Group by tr.SiteID, tr.InvtID, tr.TranType


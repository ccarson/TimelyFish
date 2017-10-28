
CREATE  VIEW [dbo].[cfv_Inventory_Recon]

 AS
SELECT 	tr.InvtId, tr.SiteID, tr.PerPost,
	Receipts = Sum(CASE tr.TranType
	WHEN 'AJ' Then 0
	ELSE (tr.CnvFact * tr.Qty * tr.InvtMult) END), 
	Adjustments = Sum(CASE tr.TranType
	WHEN 'AJ' Then (tr.Qty*tr.CnvFact * tr.InvtMult)
	ELSE 0 END),
	UnitCost =	CASE invt.ClassID
				WHEN 'RATION' THEN itemsite.AvgCost
				ELSE itemsite.StdCost
			END
	FROM [$(SolomonApp)].dbo.InTran tr 
	JOIN [$(SolomonApp)].dbo.Inventory invt ON tr.InvtId=invt.INvtId
    JOIN [$(SolomonApp)].dbo.ItemSite itemsite ON itemsite.InvtID = invt.InvtID AND itemsite.SiteID = tr.SiteID
	JOIN [$(SolomonApp)].dbo.GlSetup gls ON tr.PerPost=gls.PerNbr
	Where invt.ClassID IN ('BAG','CORN','ING','FGM','RATION') AND tr.TranType<>'CT' AND tr.Rlsed='1'
	Group by tr.InvtId, tr.PerPost, tr.SiteID, invt.ClassID, itemsite.StdCost, itemsite.AvgCost

GO
GRANT SELECT
    ON OBJECT::[dbo].[cfv_Inventory_Recon] TO PUBLIC
    AS [dbo];


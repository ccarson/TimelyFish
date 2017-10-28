
CREATE VIEW [dbo].[cfv_INVENTORY_COUNT]
AS
--SELECT pd.PIID, pd.SiteID, st.Name, pd.InvtID, pd.ItemDesc, inv.ClassID, 
--pd.PerClosed AS BegPeriod, pd.PhysQty As BegPhysical, 
--inr.Receipts, inr.Adjustments, inr.PerPost As EndPeriod, 
--pds.PhysQty As EndPhysical, inr.UnitCost
--FROM [$(SolomonApp)].dbo.PIDetail pd
--JOIN [$(SolomonApp)].dbo.Inventory inv ON pd.InvtId=inv.InvtId
--JOIN [$(SolomonApp)].dbo.Site st ON pd.SiteID=st.SiteID
--LEFT JOIN dbo.cfv_Inventory_Recon inr ON pd.SiteID=inr.SiteID AND pd.InvtID=inr.InvtID
--LEFT JOIN [$(SolomonApp)].dbo.PIDetail pds ON pd.SiteID=pds.SiteID AND pd.InvtID=pds.InvtID AND rtrim(pds.PerClosed)=''
SELECT pd.PIID, inr.SiteID, st.Name, pd.InvtID, pd.ItemDesc, inv.ClassID, 
pd.PerClosed AS BegPeriod, pd.PhysQty As BegPhysical, 
inr.Receipts, inr.Adjustments, inr.PerPost As EndPeriod, 
pds.PhysQty As EndPhysical, inr.UnitCost
FROM dbo.cfv_Inventory_Recon inr
JOIN [$(SolomonApp)].dbo.Inventory inv ON inv.InvtID = inr.InvtID
JOIN [$(SolomonApp)].dbo.Site st ON inr.SiteID=st.SiteID
LEFT JOIN [$(SolomonApp)].dbo.PIDetail pd ON pd.InvtId=inv.InvtId and pd.siteid = inr.siteid
LEFT JOIN [$(SolomonApp)].dbo.PIDetail pds ON pd.SiteID=pds.SiteID AND pd.InvtID=pds.InvtID AND rtrim(pds.PerClosed)=''

GO
GRANT SELECT
    ON OBJECT::[dbo].[cfv_INVENTORY_COUNT] TO PUBLIC
    AS [dbo];


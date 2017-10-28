CREATE VIEW cfvInventoryCount
AS


SELECT pd.PIID, pd.SiteID, st.Name, pd.InvtID, pd.ItemDesc, inv.ClassID, 
pd.PerClosed AS BegPeriod, pd.PhysQty As BegPhysical, 
inr.Receipts, inr.Adjustments, inr.PerPost As EndPeriod, 
pds.PhysQty As EndPhysical
FROM PIDetail pd
JOIN Inventory inv ON pd.InvtId=inv.InvtId
JOIN Site st ON pd.SiteID=st.SiteID
LEFT JOIN cfvInventoryRecon inr ON pd.SiteID=inr.SiteID AND pd.InvtID=inr.InvtID
LEFT JOIN PIDetail pds ON pd.SiteID=pds.SiteID AND pd.InvtID=pds.InvtID AND pds.PerClosed=inr.PerPost



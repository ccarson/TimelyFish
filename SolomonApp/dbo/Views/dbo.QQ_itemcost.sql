
CREATE VIEW [QQ_itemcost]
AS
SELECT		IC.InvtID AS [Inventory ID], I.Descr AS [Inventory ID Description], I.ValMthd AS [Valuation Method], 
			I.LotSerTrack AS [Lot/Serial Tracked], I.LinkSpecId AS [Linked to Specific Cost ID], I.StkUnit AS [Stocking UOM], 
			I.ClassID AS [Product Class], IC.SiteID, Site.Name AS [Site ID Description], IC.SpecificCostID, 
			IC.RcptNbr AS [Receipt Number], convert(date,IC.RcptDate) AS [Receipt Date], IC.LayerType, IC.Qty AS Quantity, IC.UnitCost, 
			IC.TotCost AS [Total Cost], IC.BMITotCost AS [BiMonetary Inventory Cost], IC.CostIdentity, 
			convert(date,IC.Crtd_DateTime) AS [Create Date], IC.Crtd_Prog AS [Create Program], IC.Crtd_User AS [Create User], 
			convert(date,IC.LUpd_DateTime) AS [Last Update Date], IC.LUpd_Prog AS [Last Update Program], IC.LUpd_User AS [Last Update User], 
			IC.NoteID, IC.S4Future03 AS [Quantity Shipped Not Invoiced], IC.User1, IC.User2, IC.User3, IC.User4,
			IC.User5, IC.User6, convert(date,IC.User7) AS [User7], convert(date,IC.User8) AS [User8]
FROM	ItemCost IC with (nolock)
			INNER JOIN Inventory I with (nolock) ON IC.InvtID = I.InvtID 
			INNER JOIN Site with (nolock) ON IC.SiteID = Site.SiteId


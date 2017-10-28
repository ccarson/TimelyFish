
CREATE VIEW [QQ_location]
AS
SELECT	L.InvtID AS [Inventory ID], I.Descr AS [Inventory ID Description], L.SiteID, Site.Name AS [Site ID Description], 
	L.WhseLoc AS [Warehouse Bin Location], LT.Descr AS [Warehouse Bin Location Description], L.QtyOnHand AS [Quantity On Hand], 
	L.QtyAvail AS [Quantity Available], L.CountStatus AS [Phsyical Inventory Count Status], convert(date,L.Crtd_DateTime) AS [Create Date], 
	L.Crtd_Prog AS [Create Program], L.Crtd_User AS [Create User], convert(date,L.LUpd_DateTime) AS [Last Update Date], 
	L.LUpd_Prog AS [Last Update Program], L.LUpd_User AS [Last Update User], L.NoteID AS [Location Note ID], 
	L.PrjINQtyAlloc AS [Project Inventory Quantity Allocated], L.PrjINQtyAllocIN AS [Project Inventory Quantity Allocated to Inventory], 
	L.PrjINQtyAllocPORet AS [Project Inventory Quantity Allocated to PO Returns], 
	L.PrjINQtyAllocSO AS [Project Inventory Quantity Allocated to Sales], L.PrjINQtyShipNotInv AS [Project Inventory Quantity Shipped Not Invoiced], 
	L.QtyAlloc AS [Quantity Allocated], L.QtyAllocBM AS [Quantity Allocated to Bills of Material], 
	L.QtyAllocIN AS [Quantity Allocated to Inventory], L.QtyAllocOther AS [Quantity Allocated to Other], 
	L.QtyAllocPORet AS [Quantity Allocated to PO Returns], L.QtyAllocProjIN AS [Quantity Allocated to Project Inventory], 
	L.QtyAllocSD AS [Quantity Allocated to Service Calls], L.QtyAllocSO AS [Quantity Allocated to Sales], 
	L.QtyShipNotInv AS [Quantity Shipped Not Invoiced], L.QtyWORlsedDemand AS [Quantity Work Order Released Demand], 
	L.Selected, L.User1, L.User2, L.User3, L.User4, L.User5, L.User6, 
	convert(date,L.User7) AS [User7], convert(date,L.User8) AS [User8], LT.ABCCode AS [Physical Inventory ABC Code], LT.AssemblyValid AS [Assembly Allowed], 
	LT.BinType AS [Location Type], LT.CycleID AS [Physical Inventory Cycle ID], LT.InclQtyAvail AS [Include in Quantity Available], 
	LT.InvtIDValid AS [Inventory Validation], LT.LastBookQty AS [Last Book Quantity], convert(date,LT.LastCountDate) AS [LastCountDate], 
	LT.LastVarAmt AS [Last Variance Amount], LT.LastVarPct AS [Last Variance Percent], LT.LastVarQty AS [Last Variance Quantity], 
	LT.MoveClass AS [Physical Inventory Movement Class], LT.NoteID AS [LocTable Note ID], LT.PickPriority, 
	LT.PutAwayPriority, LT.ReceiptsValid AS [Receipts Allowed], LT.SalesValid AS [Sales Allowed], 
	LT.User1 AS [LocTable User 1], LT.User2 AS [LocTable User 2], LT.User3 AS [LocTable User 3], 
	LT.User4 AS [LocTable User 4], LT.User5 AS [LocTable User 5], LT.User6 AS [LocTable User 6], 
	convert(date,LT.User7) AS [LocTable User 7], convert(date,LT.User8) AS [LocTable User 8], LT.S4Future11 AS [Work Order Issue Allowed], 
	LT.S4Future12 AS [Work Order Production Allowed]
FROM	Location L with (nolock)
			INNER JOIN Inventory I with (nolock) ON L.InvtID = I.InvtID 
			INNER JOIN LocTable LT with (nolock) ON L.WhseLoc = LT.WhseLoc 
			INNER JOIN Site with (nolock) ON L.SiteID = Site.SiteId


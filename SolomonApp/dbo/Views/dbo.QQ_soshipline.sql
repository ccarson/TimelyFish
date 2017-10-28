
CREATE VIEW [QQ_soshipline]
AS
SELECT	
				l.CpnyID AS [Company ID], h.CustID AS [Customer ID], CASE WHEN CHARINDEX('~', c.Name) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(c.Name, 1, 
				CHARINDEX('~', c.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(c.Name, CHARINDEX('~', c.Name) + 1, 60)))) ELSE c.Name END AS [Customer Name], 
				h.CustOrdNbr AS [Customer Order Number], h.OrdNbr AS [Order Number], l.ShipperID, l.LineRef AS [Line Reference Number], l.InvtID AS [Inventory ID], 
				l.SiteID, l.QtyOrd AS [Quantity Ordered], l.QtyShip AS [Quantity Shipped], l.QtyBO AS [Quantity Backordered], l.UnitDesc AS [Unit Description], 
				l.Cost AS [Unit Cost], l.TotCost AS [Total Cost], l.SlsPrice AS [Unit Price], l.TotInvc AS [Total Invoiced], h.Status AS [Shipper Status], 
				l.Status AS [Line Status], h.DropShip, l.ProjectID, l.TaskID, l.AlternateID, l.AltIDType AS [Alternate ID Type], l.S4Future03 AS [Average Cost], 
				l.ChainDisc AS [Chain Discount], l.CmmnPct AS [Commission Percent], l.CnvFact AS [Conversion Factor], l.COGSAcct AS [COGS Account], 
				l.COGSSub AS [COGS Subaccount], l.CommCost AS [Commissionable Cost], convert(date,l.Crtd_DateTime) AS [Create Date], l.Crtd_Prog AS [Create Program], 
				l.Crtd_User AS [Create User], l.CuryCommCost AS [Currency Commissionable Cost], l.CuryCost AS [Currency Cost], l.CuryListPrice AS [Currency List Price], 
				l.CurySlsPrice AS [Currency Sales Price], l.CuryTaxAmt00 AS [Currency Tax Amount 00], l.CuryTaxAmt01 AS [Currency Tax Amount 01], 
				l.CuryTaxAmt02 AS [Currency Tax Amount 02], l.CuryTaxAmt03 AS [Currency Tax Amount 03], l.CuryTotCommCost AS [Currency Total Commissionable Cost], 
				l.CuryTotCost AS [Currency Total Cost], l.CuryTotInvc AS [Currency Total Invoiced], l.CuryTotMerch AS [Currency Total Merchandise], 
				l.CuryTxblAmt00 AS [Currency Taxable Amount 00], l.CuryTxblAmt01 AS [Currency Taxable Amount 01], l.CuryTxblAmt02 AS [Currency Taxable Amount 02], 
				l.CuryTxblAmt03 AS [Currency Taxable Amount 03], l.Descr AS [Description], l.DescrLang AS [Description Language], l.DiscAcct AS [Discount Account], 
				l.DiscSub AS [Discount Subaccount], l.DiscPct AS [Discount Percent], l.Disp AS [Disposition], l.InspID AS [Inspection ID], 
				l.InspNoteID AS [Inspection Note ID], l.InvAcct AS [Inventory Account], l.InvSub AS [Inventory Subaccount], l.IRDemand AS [Inventory Replenishment Demand], 
				l.IRInvtID AS [Inventory Replenishment Inventory ID], l.IRSiteID AS [Inventory Replenishment Site ID], l.ItemGLClassID, l.ListPrice, 
				l.LotSerCntr AS [Lot/Serial Counter], convert(date,l.LUpd_DateTime) AS [Last Update Date], l.LUpd_Prog AS [Last Update Program], 
				l.LUpd_User AS [Last Update User], l.ManualCost, l.ManualPrice, l.NoteID, l.OrdLineRef AS [Order Line Reference Number], 
				l.OrigBO AS [Original Backordered Quantity], l.OrigINBatNbr AS [Original Inventory Batch Number], l.OrigInvcNbr AS [Original Invoice Number], 
				l.OrigInvtID AS [Original Inventory ID], l.OrigShipperID AS [Original Shipper ID], l.OrigShipperLineRef AS [Original Shipper Line Reference Number], 
				l.QtyFuture AS [Quantity Future], l.QtyPick AS [Quantity Pick], l.QtyPrevShip AS [Quantity Previously Shipped], l.Sample, l.ShipWght AS [Shipment Weight], 
				l.SlsAcct AS [Sales Account], l.SlsSub AS [Sales Subaccount], l.SlsperID AS [Salesperson ID], l.SlsPrice AS [Sales Price], l.SlsPriceID AS [Sales Price ID], 
				l.SplitLots, l.Taxable, l.TaxAmt00 AS [Tax Amount 00], l.TaxAmt01 AS [Tax Amount 01], l.TaxAmt02 AS [Tax Amount 02], l.TaxAmt03 AS [Tax Amount 03], 
				l.TaxCat AS [Tax Category], l.TaxID00, l.TaxID01, l.TaxID02, l.TaxID03, l.TaxIDDflt AS [Tax ID Default], l.TotCommCost AS [Total Commissionable Cost], 
				l.TotMerch AS [Total Merchandise], l.TxblAmt00 AS [Taxable Amount 00], l.TxblAmt01 AS [Taxable Amount 01], l.TxblAmt02 AS [Taxable Amount 02], 
				l.TxblAmt03 AS [Taxable Amount 03], l.UnitMultDiv AS [Unit Multiply/Divide], l.User1, l.User2, l.User3, l.User4, l.User5, l.User6, l.User7, l.User8, 
				convert(date,l.User9) AS [User9], convert(date,l.User10) AS [User10]
FROM         SOShipLine l with (nolock)
				INNER JOIN SOShipHeader h with (nolock) ON l.CpnyID = h.CpnyID AND l.ShipperID = h.ShipperID 
				INNER JOIN Customer c with (nolock) ON h.CustID = c.CustId



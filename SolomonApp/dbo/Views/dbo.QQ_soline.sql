
CREATE VIEW [QQ_soline]
AS
SELECT     	      l.CpnyID AS [Company ID], convert(date,h.OrdDate) as [Ordered Date], h.CustOrdNbr AS [Customer Order Number], 
                      h.CustID AS [Customer ID], CASE WHEN CHARINDEX('~', c.Name) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(c.Name, 1, 
                      CHARINDEX('~', c.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(c.Name, CHARINDEX('~', c.Name) + 1, 60)))) 
                      ELSE c.Name END AS [Customer Name], l.OrdNbr AS [Order Number], l.LineRef AS [Line Reference Number], 
                      l.InvtID AS [Inventory ID], l.SiteID AS [Line Site ID], l.QtyOrd AS [Quantity Ordered], l.QtyShip AS [Quantity Shipped], 
                      l.QtyBO AS [Quantity Backordered], l.UnitDesc AS [UOM], l.Cost AS [Unit Cost], l.TotCost AS [Total Cost], l.SlsPrice AS [Unit Price], 
                      l.TotOrd AS [Total Ordered], h.Status AS [Order Status], l.Status AS [Line Status], l.DropShip, 
                      convert(date,l.ReqDate) AS [Requested Date], l.ProjectID, l.TaskID, l.AlternateID, l.AltIDType AS [Alternate ID Type], 
                      l.AutoPO AS [Automatic PO], l.AutoPOVendID AS [Automatic PO Vendor ID], l.S4Future11 AS [Blanket Order Line Reference], 
                      l.S4Future04 AS [Blanket Order Quantity], l.BoundToWO AS [Bound to Work Order], convert(date,l.CancelDate) AS [Cancel By Date], 
                      l.ChainDisc AS [Chain Discount], l.CmmnPct AS [Commission Percent], l.CnvFact AS [Conversion Factor], 
                      l.COGSAcct AS [COGS Account], l.COGSSub AS [COGS Subaccount], l.CommCost AS [Commissionable Cost], 
                      convert(date,l.Crtd_DateTime) AS [Create Date], l.Crtd_Prog AS [Create Program], l.Crtd_User AS [Create User], 
                      l.CuryCommCost AS [Currency Commissionable Cost], l.CuryCost AS [Currency Cost], l.CuryListPrice AS [Currency List Price], 
                      l.CurySlsPrice AS [Currency Sales Price], l.CurySlsPriceOrig AS [Currency Sales Price Original], 
                      l.S4Future05 AS [Currency Sales Price Original Normalized], l.CuryTotCommCost AS [Currency Total Commissionable Cost], 
                      l.CuryTotCost AS [Currency Total Cost], l.CuryTotOrd AS [Currency Total Ordered], l.Descr AS [Description], l.DescrLang AS [Description Language], 
                      l.DiscAcct AS [Discount Account], l.DiscSub AS [Discount Subaccount], l.DiscPct AS [Discount Percent], l.DiscPrcType AS [Discount Price Type], 
                      l.Disp AS [Disposition], l.S4Future06 AS [EDI Line ID], l.S4Future10 AS [Include Forecast Usage Calculation], 
                      l.InspID AS [Inspection ID], l.InspNoteID AS [Inspection Note ID], l.InvAcct AS [Inventory Account], 
                      l.InvSub AS [Inventory Subaccount], l.IRDemand AS [Inventory Replenishment Demand], 
                      l.IRInvtID AS [Inventory Replenishment Inventory ID], l.IRProcessed AS [Inventory Replenishment Processed], 
                      l.IRSiteID AS [Inventory Replenishment Site ID], l.ItemGLClassID, l.S4Future09 AS [Kit Component], l.ListPrice, 
                      l.LotSerialReq AS [Lot/Serial Required], convert(date,l.LUpd_DateTime) AS [Last Update Date], l.LUpd_Prog AS [Last Update Program], 
                      l.LUpd_User AS [Last Update User], l.ManualCost, l.ManualPrice, l.NoteId, 
                      l.OrigINBatNbr AS [Original Inventory Batch Number], l.S4Future01 AS [Original Invoice Number], 
                      l.OrigInvtID AS [Original Inventory ID], l.OrigShipperCnvFact AS [Origional Shipper Conversion Factor], 
                      l.OrigShipperID AS [Original Shipper ID], l.OrigShipperLineQty AS [Original Shipper Line Quantity], 
                      l.OrigShipperLineRef AS [Original Shipper Line Reference Number], l.OrigShipperUnitDesc AS [Original Shipper UOM], 
                      l.OrigShipperMultDiv AS [Original Shipper Multiple/Divide], l.PC_Status AS [Project Controller Status], convert(date,l.PromDate) AS [Promised Date], 
                      l.QtyCloseShip AS [Quantity on Closed Shippers], l.QtyFuture AS [Quantity Future], l.QtyOpenShip AS [Quantity on Open Shippers], 
                      l.QtyToInvc AS [Quantity To Be Invoiced], l.ReasonCd AS [Reason Code], l.S4Future02 AS [Sales Price ID], l.Sample, 
                      l.SchedCntr AS [Schedule Counter], l.ShipWght AS [Shipment Weight], l.SlsAcct AS [Sales Account], l.SlsSub AS [Sales Subaccount], 
                      l.SlsperID AS [Salesperson ID], l.SlsPriceOrig AS [Original Sales Price], l.SplitLots, l.Taxable, 
                      l.TaxCat AS [Tax Category], l.TotCommCost AS [Total Commissionable Cost], l.TotShipWght AS [Total Shipment Weight], 
                      l.UnitMultDiv AS [Unit Multiple/Divide], l.User1, l.User2, l.User3, l.User4, l.User5, l.User6, l.User7, l.User8, 
                      convert(date,l.User9) AS [User9], convert(date,l.User10) AS [User10]
FROM         SOLine l with (nolock)
				INNER JOIN SOHeader H with (nolock) ON l.CpnyID = h.CpnyID AND l.OrdNbr = h.OrdNbr
				INNER JOIN Customer C with (nolock) ON H.CustID = C.CustId


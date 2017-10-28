
CREATE VIEW [QQ_rqreqdet]
AS
SELECT	D.CpnyID AS [Company ID], D.ReqNbr AS [Requisition Number], D.ReqCntr AS [Requisition Counter], H.POType AS [Purchase Order Type], D.Status, 
		H.Requstnr AS Requisitioner, H.RequstnrName AS [Requisitioner Name], H.VendID AS [Vendor ID], CASE WHEN CHARINDEX('~' , V.Name) > 0 THEN CONVERT (CHAR(60) , 
		LTRIM(SUBSTRING(V.Name, 1 , CHARINDEX('~' , V.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(V.Name, CHARINDEX('~' , V.Name) + 1 , 60)))) ELSE V.Name END 
		AS [Vendor Name], D.ItemLineRef AS [Item Number], D.InvtID AS [Inventory ID], D.Acct AS Account, D.Sub AS Subaccount, D.Budgeted, D.Qty AS Quantity, 
		D.UnitCost, D.ExtCost AS [Extended Cost], D.AddlCostPct AS [Additional Cost Percent], D.AllocCntr AS [Allocation Counter], D.AlternateID, D.AltIDType 
		AS [Alternate ID Type], D.AppvLevObt AS [Approval Level Obtained], D.AppvLevReq AS [Approval Level Required], D.BlktLineRef AS [Blanket Line Reference Number], 
		D.Buyer, D.CatalogInfo, D.CnvFact AS [Conversion Factor], D.ComitAmt AS [Commitment Amount], D.CommitAmtLeft AS [Commitment Amount Remaining], D.CostReceived, 
		D.CostReturned, D.CostVouched, CONVERT(DATE,D.crtd_datetime) AS [Create Date], D.crtd_prog AS [Create Program], D.crtd_user AS [Create User], 
		D.CuryComitAmt AS [Currency Commitment Amount], D.CuryCostReceived AS [Currency Cost Received], D.CuryCostReturned AS [Currency Cost Returned], 
		D.CuryCostVouched AS [Currency Cost Vouchered], D.CuryExtCost AS [Currency Extended Cost], D.CuryID AS [Currency ID], D.CuryMultDiv 
		AS [Currency Multiply/Divide], D.CuryRate AS [Currency Rate], D.CuryTaxAmt00 AS [Currency Tax Amount 01], D.CuryTaxAmt01 AS [Currency Tax Amount 02], 
		D.CuryTaxAmt02 AS [Currency Tax Amount 03], D.CuryTaxAmt03 AS [Currency Tax Amount 04], D.CuryTxblAmt00 AS [Currency Taxable Amount 01], 
		D.CuryTxblAmt01 AS [Currency Taxable Amount 02], D.CuryTxblAmt02 AS [Currency Taxable Amount 03], D.CuryTxblAmt03 AS [Currency Taxable Amount 04], 
		D.CuryUnitCost AS [Currency Unit Cost], D.Dept AS Department, D.Descr AS Description, D.ExtWeight AS [Extended Weight], D.FlatRateLineNbr, 
		D.ItemReqNbr AS [Item Request Number], D.KitUnExpld AS [Kit Unexplode ID], D.Labor_Class_CD AS [Labor Class Code], D.LineKey, D.LineNbr, 
		CONVERT(DATE,D.lupd_datetime) AS [Last Update Date], D.lupd_prog AS [Last Update Program], D.lupd_user AS [Last Update User], D.MaterialType, D.NoteID, 
		D.OpenLine, D.OrigPOLine AS [Original Purchase Order Line], D.OrigPOSeq AS [Original Purchase Order Sequence], D.PC_Flag AS [Project Flag], 
		D.PC_ID AS [Project Code], D.PC_Status AS [Project Status], D.PolicyLevObt AS [Policy Approval Level Obtained], 
		D.PolicyLevReq AS [Policy Approval Level Required], D.PrefVendID AS [Preferred Vendor ID], D.Project, CONVERT(DATE,D.PromiseDate) AS [Promise Date], 
		D.PurchaseFor, D.QtyRcvd AS [Quantity Received], D.QtyReturned AS [Quantity Returned], D.QtyVouched AS [Quantity Vouchered], D.RcptPctAct 
		AS [Receipt Percent Action Indicator], D.RcptPctMax AS [Receipt Percent Maximum], D.RcptPctMin AS [Receipt Percent Minimum], D.RcptStage AS [Receipt Stage], 
		D.ReasonCD AS [Reason Code], CONVERT(DATE,D.RequiredDate) AS [Required Date], D.S4Future1, D.S4Future2, D.S4Future3, D.S4Future4, D.S4Future5, 
		D.S4Future6, CONVERT(DATE,D.S4Future7) AS [S4Future7], CONVERT(DATE,D.S4Future8) AS [S4Future8], D.S4Future9, D.S4Future10, D.S4Future11, D.S4Future12, 
		D.SeqNbr AS [Sequence Number], D.ShelfLife, D.ShipAddr1 AS [Shipping Address 1], D.ShipAddr2 AS [Shipping Address 2], D.ShipAddrID AS [Shipping Address ID], 
		D.ShipCity AS [Shipping City], D.ShipCountry AS [Shipping Country/Region], D.ShipFrom, D.ShipName AS [Shipping Name], D.ShipState AS [Shipping State/Province], 
		D.ShipViaID, D.ShipZip AS [Shipping Zip/Postal Code], D.SiteID, D.SOLineRef AS [Sales Order Line Reference Number], D.SOOrdNbr AS [Sales Order Number], 
		D.SOSchedRef AS [Sales Order Schedule Reference Number], D.StepNbr AS [Step Number], D.SupplrItem1 AS [Supplier Item Number], D.SvcContractID 
		AS [Service Contract ID], D.SvcLineNbr AS [Service Contract Line Number], D.Task, D.TaxAmt00 AS [Tax Amount 01], D.TaxAmt01 AS [Tax Amount 02], 
		D.TaxAmt02 AS [Tax Amount 03], D.TaxAmt03 AS [Tax Amount 04], D.TaxCalced AS [Tax Calculated], D.TaxCat AS [Tax Category], D.TaxID00 AS [Tax ID 01], 
		D.TaxID01 AS [Tax ID 02], D.TaxID02 AS [Tax ID 03], D.TaxID03 AS [Tax ID 04], D.TaxIDDflt AS [Tax ID Default], D.Transfer, D.TxblAmt00 AS [Taxable Amount 01], 
		D.TxblAmt01 AS [Taxable Amount 02], D.TxblAmt02 AS [Taxable Amount 03], D.TxblAmt03 AS [Taxable Amount 04], D.Unit AS [Unit of Measure], D.UnitMultDiv 
		AS [Unit Multiply/Divide], D.UnitWeight AS [Unit Weight], D.User1, D.User2, D.User3, D.User4, D.User5, D.User6, CONVERT(DATE,D.User7) AS [User7], 
		CONVERT(DATE,D.User8) AS [User8], D.VendItemID AS [Vendor Item ID], D.VouchStage AS [Vouchered Stage], D.WOBOMSeq 
		AS [Work Order Bill of Material Sequence Number], D.WOCostType AS [Work Order Cost Type], D.WONbr AS [Work Order Number], D.WOStepNbr 
		AS [Work Order Step Number]
		
FROM	RQReqDet D with (nolock) 
			INNER JOIN RQReqHdr H with (nolock) ON D.CpnyID = H.CpnyID AND D.ReqNbr = H.ReqNbr 
			LEFT OUTER JOIN Vendor V with (nolock) ON H.VendID = V.VendId


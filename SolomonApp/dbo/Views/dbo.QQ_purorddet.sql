
CREATE VIEW [QQ_purorddet]
AS
SELECT     D.CpnyID AS [Company ID], D.PONbr AS [PO Number], D.LineRef AS [Line Reference Number], 
                      D.PurchaseType AS [Purchase For], D.InvtID AS [Inventory ID], I.Descr AS [Inventory ID Description], D.SiteID, 
                      D.PurchUnit AS [Purchase UOM], D.QtyOrd AS [Quantity Ordered], D.UnitCost, D.ExtCost AS [Extended Cost], 
                      D.QtyRcvd AS [Quantity Received], D.CostReceived AS [Cost Received], D.RcptStage AS [Receipt Stage], 
                      D.QtyReturned AS [Quantity Returned], D.CostReturned AS [Cost Returned], D.QtyVouched AS [Quantity Vouchered], 
                      D.CostVouched AS [Cost Vouchered], D.VouchStage AS [Vouchered Stage], P.Status AS [PO Status], 
                      D.OpenLine AS [Open PO Line], D.TranDesc AS [Transaction Description], D.ProjectID, D.TaskID, 
                      D.PurAcct AS [Purchasing Account], D.PurSub AS [Purchasing Subaccount], D.AddlCostPct AS [Additional Cost Percent], 
                      D.AlternateID, D.AltIDType AS [Alternate ID Type], D.BlktLineRef AS [Blanket Line Reference Number], D.Buyer, 
                      D.CnvFact AS [Conversion Factor], convert(date,D.Crtd_DateTime) AS [Create Date], D.Crtd_Prog AS [Create Program], 
                      D.Crtd_User AS [Create User], D.CuryCostReceived AS [Currency Cost Received], 
                      D.CuryCostReturned AS [Currency Cost Returned], D.CuryCostVouched AS [Currency Cost Vouchered], 
                      D.CuryExtCost AS [Currency Extended Cost], D.CuryID AS [Currency ID], D.CuryMultDiv AS [Currency Multiply/Divide], 
                      D.CuryRate AS [Currency Rate], D.CuryTaxAmt00 AS [Currency Tax Amount 01], D.CuryTaxAmt01 AS [Currency Tax Amount 02], 
                      D.CuryTaxAmt02 AS [Currency Tax Amount 03], D.CuryTaxAmt03 AS [Currency Tax Amount 04], 
                      D.CuryTxblAmt00 AS [Currency Taxable Amount 01], D.CuryTxblAmt01 AS [Currency Taxable Amount 02], 
                      D.CuryTxblAmt02 AS [Currency Taxable Amount 03], D.CuryTxblAmt03 AS [Currency Taxable Amount 04], 
                      D.CuryUnitCost AS [Currency Unit Cost], D.ExtWeight AS [Extended Weight], D.FlatRateLineNbr AS [Flat Rate Line Number], 
                      D.S4Future10 AS [Include in Forecast Usage Calculation], D.IRIncLeadTime AS [IR Include in Lead Time], 
                      D.KitUnExpld AS [Kit Unexplode], D.Labor_Class_Cd AS [Labor Class Code], convert(date,D.LUpd_DateTime) AS [Last Update Date], 
                      D.LUpd_Prog AS [Last Update Program], D.LUpd_User AS [Last Update User], D.NoteID, 
                      D.OrigPOLine AS [Original PO Line], D.PC_Flag AS [Project Controller Flag], D.PC_ID AS [Project Controller ID], 
                      D.PC_Status AS [Project Controller Status], D.POType, convert(date,D.PromDate) AS [Promised Date], 
                      D.RcptPctAct AS [Receipt Percent Actual], D.RcptPctMax AS [Receipt Percent Maximum], 
                      D.RcptPctMin AS [Receipt Percent Minimum], D.ReasonCd AS [Reason Code], D.RefNbr AS [Reference Number], 
                      convert(date,D.ReqdDate) AS [Required Date], D.ReqNbr AS [Required Number], D.ServiceCallID, D.S4Future09 AS [Shelf Life], 
                      D.ShipAddr1 AS [Ship To Address 1], D.ShipAddr2 AS [Ship To Address 2], D.ShipAddrID AS [Ship To Address ID], 
                      D.ShipCity AS [Ship To City], D.ShipCountry AS [Ship To Country/Region], CASE WHEN CHARINDEX('~' , D.ShipName) > 0 
                      THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(D.ShipName, 1 , CHARINDEX('~' , D.ShipName) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(D.ShipName, CHARINDEX('~' , 
                      D.ShipName) + 1 , 60)))) ELSE D.ShipName END AS [Ship To Name],
                      D.ShipState AS [Ship To State], D.ShipViaID, D.ShipZip AS [Ship To Postal Code], D.StepNbr AS [Step Number], 
                      D.SvcContractID AS [Service Contract ID], D.SvcLineNbr AS [Service Call Line Number], D.TaxAmt00 AS [Tax Amount 01], 
                      D.TaxAmt01 AS [Tax Amount 02], D.TaxAmt02 AS [Tax Amount 03], D.TaxAmt03 AS [Tax Amount 04], 
                      D.TaxCalced AS [Tax Calculated], D.TaxCat AS [Tax Category], D.TaxID00 AS [Tax ID 01], D.TaxID01 AS [Tax ID 02], 
                      D.TaxID02 AS [Tax ID 03], D.TaxID03 AS [Tax ID 04], D.TaxIdDflt AS [Tax ID Default], 
                      D.TxblAmt00 AS [Taxable Amount 01], D.TxblAmt01 AS [Taxable Amount 02], D.TxblAmt02 AS [Taxable Amount 03], 
                      D.TxblAmt03 AS [Taxable Amount 04], D.UnitMultDiv AS [Unit Multiply/Divide], D.UnitWeight, D.User1, 
                      D.User2, D.User3, D.User4, D.User5, D.User6, convert(date,D.User7) AS [User7], convert(date,D.User8) AS [User8], 
                      D.WIP_COGS_Acct AS [WIP COGS Account], D.WIP_COGS_Sub AS [WIP COGS Subaccount], 
                      D.WOBOMSeq AS [Work Order/Bill of Materials Sequence], D.WOCostType AS [Work Order Cost Type], 
                      D.WONbr AS [Work Order Number], D.WOStepNbr AS [Work Order Step Number]
FROM         PurOrdDet D with (nolock)
				INNER JOIN Inventory I with (nolock) ON D.InvtID = I.InvtID 
				INNER JOIN PurchOrd P with (nolock) ON D.CpnyID = P.CpnyID AND D.PONbr = P.PONbr


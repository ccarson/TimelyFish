
CREATE VIEW [QQ_potran]
AS
SELECT     T.CpnyID AS [Company ID], T.BatNbr AS [Batch Number], B.Status AS [Batch Status], R.RcptType AS [Receipt/Return], 
                      T.RcptNbr AS [Receipt Number], convert(date,T.RcptDate) AS [Receipt Date], T.PONbr AS [PO Number], T.VendId AS [Vendor ID], 
                      T.LineRef AS [Line Reference Number], T.PurchaseType AS [Purchase Type], T.InvtID AS [Inventory ID], 
                      I.Descr AS Description, T.SiteID, T.WhseLoc AS [Warehouse Bin Location], T.Qty AS Quantity, T.UnitCost, 
                      T.ExtCost AS [Extended Cost], T.QtyVouched AS [Quantity Vouchered], 
                      T.CostVouched AS [Cost Vouchered], T.ProjectID, T.TaskID, T.TranDesc AS [Transaction Description], 
                      T.Acct AS Account, T.Sub AS Subaccount, T.VouchStage AS [Vouchered Stage], T.AcctDist AS [Account Distribution], 
                      T.AddlCost AS [Additional Cost], T.AddlCostPct AS [Additional Cost Percent], T.AlternateID, T.AltIDType AS [Alternate ID Type], 
                      T.APLineID AS [Accounts Payable Line ID], T.APLineRef AS [Accounts Payable Line Reference Number], 
                      T.BMICuryID AS [BMI Currency ID], convert(date,T.BMIEffDate) AS [BMI Effective Date], T.BMIExtCost AS [BMI Extended Cost], 
                      T.BMIMultDiv AS [BMI Multiply/Divide], T.BMIRate AS [BMI Rate], T.BMIRtTp AS [BMI Rate Type], 
                      T.BMITranAmt AS [BMI Transaction Amount], T.BMIUnitCost AS [BMI Unit Cost], T.BMIUnitPrice AS [BMI Unit Price], 
                      T.CnvFact AS [Conversion Factor], convert(date,T.Crtd_DateTime) AS [Create Date], T.Crtd_Prog AS [Create Program], 
                      T.Crtd_User AS [Create User], T.CuryAddlCost AS [Currency Additional Cost], T.CuryCostVouched AS [Currency Cost Vouchered], 
                      T.CuryExtCost AS [Currency Extended Cost], T.CuryMultDiv AS [Currency Multiply/Divide], T.CuryRate AS [Currency Rate], 
                      T.CuryTranAmt AS [Currency Transaction Amount], T.CuryUnitCost AS [Currency Unit Cost], T.DrCr AS [Debit/Credit], 
                      T.ExtWeight AS [Extended Weight], T.FlatRateLineNbr AS [Flate Rate Line Number], T.JrnlType AS [Journal Type], 
                      T.Labor_Class_Cd AS [Labor Class Code], convert(date,T.LUpd_DateTime) AS [Last Update Date], T.LUpd_Prog AS [Last Update Program], 
                      T.LUpd_User AS [Last Update User], T.NoteID, convert(date,T.OrigRcptDate) AS [Original Receipt Date], 
                      T.OrigRcptNbr AS [Original Receipt Number], T.S4Future01 AS [Original Return Receipt Number], T.PC_Flag AS [Project Controller Flag], 
                      T.PC_ID AS [Project Controller ID], T.PC_Status AS [Project Controller Status], T.PerEnt AS [Period Entered], 
                      T.PerPost AS [Period to Post], T.POLIneRef AS [PO Line Reference Number], T.POOriginal AS [Original to PO], 
                      T.RcptConvFact AS [Receipt Conversion Factor], T.RcptLineRefOrig AS [Original Receipt Line Reference Number], 
                      T.RcptMultDiv AS [Receipt Multiply/Divide], T.RcptNbrOrig AS [Receipt Number Original], T.RcptQty AS [Receipt Quantity], 
                      T.ReasonCd AS [Reason Code], T.Refnbr AS [Reference Number], T.ServiceCallID, 
                      T.SOLineRef AS [Sales Order Line Reference Number], T.SOOrdNbr AS [Sales Order Number], T.SOTypeID AS [Sales Order Type ID], 
                      T.SpecificCostID, T.StepNbr AS [Step Number], T.SvcContractID AS [Service Contract ID], 
                      T.SvcLineNbr AS [Service Call Line Number], T.S4Future11 AS [Tax Category], T.S4Future12 AS [Tax ID Default], T.TranAmt AS [Transaction Amount], 
                      convert(date,T.TranDate) AS [Transaction Date], T.TranType AS [Transaction Type], T.UnitDescr AS [Unit Description], 
                      T.UnitMultDiv AS [Unit Multiply/Divide], T.UnitWeight, T.User1, T.User2, T.User3, T.User4, 
                      T.User5, T.User6, convert(date,T.User7) AS [User7], convert(date,T.User8) AS [User8], T.WIP_COGS_Acct AS [WIP COGS Account], 
                      T.WIP_COGS_Sub AS [WIP COGS Subaccount], T.WOBomRef AS [Work Order/Bill of Material Reference], 
                      T.WOCostType AS [Work Order Cost Type], T.WONbr AS [Work Order Number], T.WOStepNbr AS [Work Order Step Number]
FROM	POTran T with (nolock) 
			INNER JOIN Batch B with (nolock) ON T.BatNbr = B.BatNbr AND T.CpnyID = B.CpnyID AND T.JrnlType = B.JrnlType
			INNER JOIN Inventory I with (nolock) ON T.InvtID = I.InvtID 
			INNER JOIN POReceipt R with (nolock) ON T.CpnyID = R.CpnyID AND T.BatNbr = R.BatNbr AND T.RcptNbr = R.RcptNbr


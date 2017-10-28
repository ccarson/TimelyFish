
CREATE VIEW [QQ_intran]
AS
        SELECT     i.BatNbr AS [Batch Number], i.LineRef AS [Line Reference Number], i.RefNbr AS [Reference Number], 
                      i.TranType AS [Transaction Type], i.JrnlType AS [Journal Type], i.InvtID AS [Inventory ID], n.ValMthd AS [Valuation Method], 
                      n.Descr AS Description, i.SiteID, i.WhseLoc AS [Warehouse Bin Location], i.SpecificCostID, 
                      i.RcptNbr AS [Receipt Number], convert(date,i.RcptDate) AS [Receipt Date], convert(date,i.TranDate) AS [Transaction Date], 
                      i.InvtMult AS [Inventory Multiplier], i.Qty AS Quantity, i.UnitDesc AS UOM, i.CnvFact AS [Conversion Factor], 
                      i.UnitCost AS [Unit Cost], i.UnitPrice AS [Unit Price], i.ExtCost AS [Total Cost], i.TranAmt AS [Total Price], 
                      i.Rlsed AS Released, i.S4Future05 AS Retired, i.S4Future09 AS [Nonstock/DropShip/CreditMemo], 
                      i.TranDesc AS [Transaction Description], i.Acct AS Account, i.AcctDist AS [Account Distribution], 
                      i.ARDocType AS [AR Document Type], i.ARLineID, i.ARLineRef AS [AR Line Reference Number], 
                      i.BMICuryID AS [BMI Currency ID], CONVERT(DATE,i.BMIEffDate) AS [BMI Effective Date], i.BMIEstimatedCost, 
                      i.BMIExtCost AS [BMI Extended Cost], i.BMIMultDiv AS [BMI Multiplier/Divider], i.BMIRate, i.BMIRtTp AS [BMI Rate Type], 
                      i.BMITranAmt AS [BMI Transaction Amount], i.BMIUnitPrice AS [BMI Unit Price], i.CmmnPct AS KitStdQty, 
                      i.COGSAcct AS [COGS Account], i.COGSSub AS [COGS Subaccount], i.CpnyID AS [Company ID], 
                      convert(date,i.Crtd_DateTime) AS [Create Date], i.Crtd_Prog AS [Create Program], i.Crtd_User AS [Create User], 
                      i.DrCr AS [Debit/Credit], b.EditScrnNbr, i.EstimatedCost, i.ExtRefNbr AS [External Reference Number], i.FiscYr AS [Fiscal Year], 
                      i.FlatRateLineNbr, i.ID AS [Customer ID], i.InsuffQty AS [Insufficient Quantity], i.InvtAcct AS [Inventory Account], 
                      i.InvtSub AS [Inventory Subaccount], i.IRProcessed AS [Processed by IR], i.KitID, i.LayerType, 
                      i.LotSerCntr AS [Lot/Serial Counter], convert(date,i.LUpd_DateTime) AS [Last Update Date], i.LUpd_Prog AS [Last Update Program], 
                      i.LUpd_User AS [Last Update User], i.NoteID, i.S4Future01 AS [Original Batch Number], 
                      i.S4Future12 AS [Original Journal Type], i.S4Future11 AS [Original Line Reference Number], 
                      i.S4Future02 AS [Original Reference Number], i.OvrhdAmt AS [Overhead Amount], i.OvrhdFlag AS [Overhead Flag], 
                      i.PC_Flag AS [Project Controller Flag], i.PC_ID, i.PC_Status AS [Project Controller Status], i.PerEnt AS [Period Entered], 
                      i.PerPost AS [Period to Post], i.PoNbr AS [Purchase Order Number], i.ProjectID, i.QtyUnCosted AS [Quantity Uncosted], 
                      i.ReasonCd AS [Reason Code], i.RecordID, i.S4Future04 AS [Original Unit Cost], i.S4Future10 AS [Use Transaction Cost], 
                      i.ServiceCallID, i.ShipperCpnyID AS [Shipper Company ID], i.ShipperID, i.ShipperLineRef AS [Shipper Line Reference Number],
                      i.SlsperID AS [Salesperson ID], CONVERT(DATE,i.SrcDate) AS [Allocation Source Date], i.SrcLineRef AS [Allocation Source Line Reference Number], 
                      i.SrcNbr AS [Allocation Source Reference Number], i.SrcType AS [Allocation Source Type], i.S4Future03 AS [Standard Total Quantity], 
                      i.Sub AS Subaccount, i.SvcContractID AS [Service Contract ID], i.SvcLineNbr AS [Service Call Line Number], i.TaskID, 
                      i.ToSiteID, i.ToWhseLoc, i.UnitMultDiv AS [Unit Multiplier/Divider], i.User1, i.User2, i.User3, 
                      i.User4, i.User5, i.User6, convert(date,i.User7) AS [User7], convert(date,i.User8) AS [User8]
FROM         INTran i with (nolock) 
				INNER JOIN Inventory n with (nolock) ON i.InvtID = n.InvtID
				INNER JOIN Batch b with (nolock) on b.BatNbr = i.BatNbr and b.CpnyID = i.CpnyID 
WHERE b.Module in ('IN','PO')


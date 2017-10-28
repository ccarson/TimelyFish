
CREATE VIEW [QQ_smservdetail]
AS
SELECT     D.CpnyID AS [Company ID], D.ServiceCallID, C.ServiceCallCompleted, C.CallStatus, 
                      C.BranchID, D.LineTypes, D.InvtId AS [Inventory ID], D.Description, D.DetailType, 
                      D.ClassID AS [Product Class], D.SiteID, D.WhseLoc AS [Warehouse Bin Location], 
                      D.WorkHr AS [Worked Hours], D.Billable AS [Billed Hours], D.Quantity, I.DfltSOUnit AS [Sales UOM], 
                      D.LotSerialRep AS [Serial Number], I.StkBasePrc AS [Base Price], D.UnitPrice, 
                      D.ExtPrice AS [Extended Price], D.InvtSpecCostID AS [Specific Cost ID], D.TaxID00 AS [Tax ID], 
                      D.TxblAmt00 AS [Taxable Amount], D.TaxAmt00 AS [Tax Amount], D.EmpID AS [Employee ID], 
                      D.EarningType AS [Earnings Type], D.WorkLoc AS [Work Location], D.Cost AS [Unit Cost], 
                      D.TranAmt AS [Extended Cost], convert(date,D.TranDate) AS [Service Date], D.VendID AS [Vendor ID], convert(date,D.PODate) AS [PODate], 
                      D.POOrderQty AS [PO Quantity Ordered], D.PORcptQty AS [PO Quantity Received], D.PONumber, 
                      C.ProjectID, D.Task, D.ServiceContract AS [Contract ID], D.EquipID AS [Equipment ID], 
                      D.Acct AS [Revenue Account], D.Sub AS [Revenue Subaccount], D.COGSAcct AS [COGS Account], 
                      D.COGSSub AS [COGS Subaccount], D.Profit, D.ProfitPercent, D.ARBatNbr AS [AR Batch Number], 
                      D.ARRefNbr AS [AR Reference Number], D.BillFlag AS Billed, D.BillingType, 
                      D.BurdenAmt AS [Burden Amount], D.BurdenPct AS [Burden Percent], D.Certified AS [Certified Payroll], 
                      D.CreateReceipt AS [PO Receipt Created], convert(date,D.Crtd_DateTime) AS [Create Date], 
                      D.Crtd_Prog AS [Create Program], D.Crtd_User AS [Create User], D.CustId AS [Customer ID], 
                      D.EarnMult AS [Earnings multiplier], D.EmpPRID AS [Employee ID in Payroll], D.FlatRateID, 
                      D.FlatRateLineNbr AS [Flat Rate Line Number], D.INBatNbr AS [IN Batch Number], D.INLineID, 
                      D.INTranFlag AS [Inventory Transaction Created], D.InvoiceInProgress, D.InvtStdCost AS [Standard Cost], 
                      D.LaborClass, D.LaborBurden, D.LotSerialPU AS [Stock UOM], 
                      convert(date,D.Lupd_DateTime) AS [Last Update Date], D.Lupd_Prog AS [Last Update Program], 
                      D.Lupd_User AS [Last Update User], D.MarkupId, D.NoteID, D.OrdLineID AS [Sales Order Line ID], 
                      D.OrdNbr AS [Sales Order Number], D.PerEnt AS [Period Entered], D.PerPost AS [Period to Post], 
                      D.PJBatNbr AS [Project Batch Number], D.PJDocNbr AS [Project Document Number], D.POCost, 
                      D.POFlag AS [PO Created], D.PRBatchNbr AS [Payroll Batch Number], D.PRCreated AS [Payroll Created], 
                      D.PRDocNBr AS [Payroll Document Number], D.PrevailingWageCode, D.PrevailingWageGroup, 
                      D.PRLineID AS [Payroll Line ID], D.RecptFlag AS [IN Receipt Created], D.RecptNbr AS [Receipt Number], 
                      D.RefrigRecl AS [Receipt Flag], D.ShiftCode, D.StdCost AS [Standard Cost in Stock UOM], 
                      D.TaxCat AS [Tax Category], D.TaxExempt, D.TaxIDDflt AS [Default Tax ID], 
                      D.TimeShtNbr AS [Timesheet Number], D.UnionCode, D.user1 AS User1, D.user2 AS User2, 
                      D.user3 AS User3, D.user4 AS User4, D.User5, D.User6, convert(date,D.User7) AS [User7], 
                      convert(date,D.User8) AS [User8], D.WarrantyApproval, D.WarrantyCustId AS [Warranty Customer ID], 
                      D.WorkersComp AS [Workers Compensation Code], D.WorkType
FROM	SMServDetail D with (nolock)
			INNER JOIN smServCall C with (nolock) ON D.CpnyID = C.CpnyID AND D.ServiceCallID = C.ServiceCallID 
			INNER JOIN Inventory I with (nolock) ON D.InvtId = I.InvtID


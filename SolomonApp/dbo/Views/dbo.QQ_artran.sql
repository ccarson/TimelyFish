
CREATE VIEW [QQ_artran]
AS
SELECT 
     a.BatNbr AS [Batch Number], a.Rlsed AS [Released],a.RefNbr AS [Reference Number],a.TranType AS [Transaction Type],a.TranDesc AS [Transaction Description],
     a.CustId AS [Customer ID],CASE WHEN CHARINDEX('~', C.Name) > 0 THEN CONVERT(CHAR(60), 
	 LTRIM(SUBSTRING(C.Name, 1, CHARINDEX('~',C.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX('~',C.Name) + 1, 60)))) ELSE C.Name END AS [Customer Name], 
     b.Terms, a.Qty AS [Quantity], a.TranAmt AS [Transaction Amount], convert(date,a.TranDate) AS [Transaction Date],
     b.DiscBal AS [Discount Balance], convert(date,b.DiscDate) AS [Discount Date], convert(date,b.DueDate) AS [DueDate], a.PerPost AS [Period To Post],
     a.Acct AS [Account], a.Sub AS [Subaccount], a.AcctDist AS [Account Distribution] ,a.CmmnPct As [Commission Percent], a.CnvFact AS [Conversion Factor], 
     a.ContractID, a.CostType, a.CpnyID AS [Company ID], convert(date,a.Crtd_DateTime) AS [Create Date], a.Crtd_Prog AS [Create Program], 
     a.Crtd_User AS [Create User], a.CuryExtCost AS [Currency Extended Cost], a.CuryId AS [Currency ID], a.CuryMultDiv AS [Currency Multiply/Divide], a.CuryRate AS [Currency Rate], 
     a.CuryTaxAmt00 AS [Currency Tax Amount 01], a.CuryTaxAmt01 AS [Currency Tax Amount 02], a.CuryTaxAmt02 AS [Currency Tax Amount 03],a.CuryTaxAmt03 AS [Currency Tax Amount 04], a.CuryTranAmt AS [Currency Transaction Amount], 
     a.CuryTxblAmt00 AS [Currency Taxable Amount 01], a.CuryTxblAmt01 AS [Currency Taxable Amount 02], a.CuryTxblAmt02 AS [Currency Taxable Amount 03], a.CuryTxblAmt03 AS [Currency Taxable Amount 04], a.CuryUnitPrice AS [Currency Unit Price], 
     a.DrCr AS [Debit/Credit], a.Excpt AS [Grid Line is User Loaded], a.ExtCost AS [Extended Cost], 
     a.FiscYr AS [Fiscal Year], a.FlatRateLineNbr, a.InstallNbr AS [Installment Number], a.InvtId AS [Inventory ID], a.JobRate, 
     a.JrnlType AS [Journal Type], a.LineId, a.LineRef AS [Line Reference Number], convert(date,a.LUpd_DateTime) AS [Last Update Date], 
     a.LUpd_Prog AS [Last Update Program], a.LUpd_User AS [Last Update User], a.MasterDocNbr AS [Master Document Number], a.NoteId, 
     a.PC_Flag AS [Project Controller Billable], a.PC_Status AS [Project Controller Status], a.PerEnt AS [Period Entered],  
     a.ProjectID, a.ServiceCallID, convert(date,a.ServiceDate) AS [ServiceDate], 
     a.ShipperCpnyID AS [Shipper Company ID], a.ShipperID, a.ShipperLineRef AS [Shipper Line Reference Number], a.SiteId, a.SlsperId AS [Salesperson ID], 
     a.SpecificCostID, a.TaskID, a.TaxAmt00 AS [Tax Amount 01], a.TaxAmt01 AS [Tax Amount 02], 
     a.TaxAmt02 AS [Tax Amount 03], a.TaxAmt03 AS [Tax Amount 04], a.TaxCalced AS [Tax Calculated], a.TaxCat AS [Tax Category], a.TaxId00, 
     a.TaxId01, a.TaxId02, a.TaxId03, a.TaxIdDflt AS [Tax ID Default],  
     a.TranClass AS [Transaction Class],a.TxblAmt00 AS [Taxable Amount 01], 
     a.TxblAmt01 AS [Taxable Amount 02], a.TxblAmt02 AS [Taxable Amount 03], a.TxblAmt03 AS [Taxable Amount 04], a.UnitDesc AS [Unit Description], a.UnitPrice, 
     a.User1, a.User2, a.User3, a.User4, a.User5, 
     a.User6, convert(date,a.User7) AS [User7], convert(date,a.User8) AS [User8], a.WhseLoc AS [Warehouse Bin Location]
FROM    Artran a with (nolock)
        INNER JOIN customer c with (nolock) ON a.CustID = c.CustId
        INNER JOIN Ardoc b with (nolock) ON a.batnbr = b.batnbr 



CREATE VIEW [QQ_aptran]
AS
SELECT 
     a.BatNbr AS [Batch Number],  a.Rlsed AS [Released], a.CpnyID AS [Company ID],  
     a.PerEnt AS [Period Entered], a.PerPost As [Period to Post], 
     a.RefNbr AS [Reference Number], a.VendId AS [Vendor ID], 
     CASE WHEN CHARINDEX('~', v.Name) > 0 THEN CONVERT(CHAR(60), 
	 LTRIM(SUBSTRING(v.Name, 1, CHARINDEX('~',v.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(v.Name, CHARINDEX('~',v.Name) + 1, 60)))) ELSE v.Name END AS [Vendor Name], 
     a.Acct AS [Account], a.Sub AS [Subaccount],b.docclass AS [Document Class],
     a.trantype AS [Transaction Type], a.TranDesc AS [Transaction Description], convert(date,a.TranDate) AS [Transaction Date], 
     a.Qty AS [Quantity], a.TranAmt AS [Transaction Amount],
     a.AcctDist AS [Account Distribution], a.AlternateID,  
     a.BOMLineRef AS [Bill of Material Sequence Number], 
     a.BoxNbr, a.CostType, a.CostTypeWO AS [Work Order Cost Type],  
     convert(date,a.Crtd_DateTime) AS [Create Date], a.Crtd_Prog AS [Create Program], a.Crtd_User AS [Create User], a.CuryId AS [Currency ID], a.CuryMultDiv AS [Currency Multiply/Divide], 
     a.CuryPOExtPrice AS [Currency PPO Extended Price], a.CuryPOUnitPrice AS [Currency PO Unit Price], a.CuryPPV AS [Currency Purchase Price Variance], a.CuryRate AS [Currency Rate],
     a.CuryTaxAmt00 AS [Currency Tax Amount 01], a.CuryTaxAmt01 AS [Currency Tax Amount 02], a.CuryTaxAmt02 AS [Currency Tax Amount 03],a.CuryTaxAmt03 AS [Currency Tax Amount 04],
     a.CuryTranAmt AS [Currency Transaction Amount],
     a.CuryTxblAmt00 AS [Currency Taxable Amount 01], a.CuryTxblAmt01 AS [Currency Taxable Amount 02], a.CuryTxblAmt02 AS [Currency Taxable Amount 03], a.CuryTxblAmt03 AS [Currency Taxable Amount 04], 
     a.CuryUnitPrice AS [Currency Unit Price], a.DrCr AS [Debit/Credit], 
     a.Employee, a.EmployeeID, a.ExtRefNbr AS [External Reference Number], a.FiscYr AS [Fiscal Year], 
     a.InstallNbr AS [Installment Number], a.InvcTypeID AS [Invoice Type ID], a.InvtID AS [Inventory ID], a.JobRate, a.JrnlType As [Journal Type], 
     a.Labor_Class_Cd AS [Labor Class Code], a.LCCode AS [Landed Cost Code], a.LineId, a.LineNbr AS [Line Number], a.LineRef AS [Line Reference Number], 
     a.LineType, convert(date,a.LUpd_DateTime) AS [Last Update Date], a.LUpd_Prog AS [Last Update Program], a.LUpd_User AS [Last Update User], a.MasterDocNbr AS [Master Document Number], 
     a.NoteID, a.PC_Flag AS [Project Controller Flag], a.PC_Status AS [Project Controller Status], 
     a.PmtMethod AS [Payment Method], a.POExtPrice AS [PO Extended Price], a.POLineRef AS [PO Line Reference], a.PONbr AS [PO Number], 
     a.POQty AS [PO Quantity], a.POUnitPrice, PPV AS [Purchase Price Variance], a.ProjectID,  
     a.QtyVar AS [Quantity Variance], a.RcptLineRef AS [Receipt Line Reference], a.RcptNbr AS [Receipt Number], a.RcptQty AS [Receipt Quantity], 
     a.S4Future01 AS [Purchase Price Variance (Purchasing Receipts)], a.S4Future09 AS [Final Voucher], convert(date,a.ServiceDate) AS [ServiceDate], 
     a.SiteId, a.SoLineRef AS [SO Line Reference], a.SOOrdNbr AS [SO Number], a.SOTypeID,  
     a.TaskID, a.TaxAmt00 AS [Tax Amount 01], a.TaxAmt01 AS [Tax Amount 02], 
     a.TaxAmt02 AS [Tax Amount 03], a.TaxAmt03 AS [Tax Amount 04],
     a.TaxCalced AS [Tax Calculated], a.TaxCat AS [Tax Category], a.TaxId00, a.TaxId01, a.TaxId02, 
     a.TaxId03, a.TaxIdDflt AS [Tax ID Default], a.TranClass AS [Transaction Class],  
     a.TxblAmt00 AS [Taxable Amount 01], 
     a.TxblAmt01 AS [Taxable Amount 02], a.TxblAmt02 AS [Taxable Amount 03], a.TxblAmt03 AS [Taxable Amount 04],
     a.UnitDesc AS [Unit Description], a.UnitPrice, a.User1, a.User2, 
     a.User3, a.User4, a.User5, a.User6, convert(date,a.User7) AS [User7], 
     convert(date,a.User8) AS [User8], a.WONbr AS [Work Order Number], a.WOStepNbr AS [Work Order Step number]
FROM    Aptran a with (nolock)
        INNER JOIN Vendor v with (nolock) ON a.VendID = v.VendId
        INNER JOIN Apdoc b with (nolock) ON a.batnbr = b.batnbr
        and a.RefNbr = b.RefNbr 


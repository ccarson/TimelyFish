
CREATE VIEW [dbo].[QQ_apdoc_recur]
AS
SELECT
     a.BatNbr AS [Batch Number], a.Rlsed AS [Released], a.VendId,CASE WHEN CHARINDEX('~', v.Name) > 0 THEN CONVERT(CHAR(60), 
	 LTRIM(SUBSTRING(v.Name, 1, CHARINDEX('~',v.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(v.Name, CHARINDEX('~',v.Name) + 1, 60)))) ELSE v.Name END AS [Vendor Name], 
     a.RefNbr As [Reference Number],a.DocType AS [Document Type], a.DocDesc AS [Document Description],a.Status,
     convert(date,a.DocDate) AS [Document Date], a.PONbr AS [PO Number], a.InvcNbr AS [Invoice Number],  convert(date,a.InvcDate) AS [Invoice Date],  a.Terms AS [Terms ID],
      convert(date,a.DiscDate) AS [Discount Date], convert(date,a.DueDate) AS [DueDate], convert(date,a.PayDate) AS [PayDate], a.OrigDocAmt AS [Original Document Amount],
     a.DocBal AS [Document Balance], a.CpnyID AS [Company ID],
     a.Acct AS [Account], a.ApplyAmt AS [Applied Amount], convert(date,a.ApplyDate) AS [Applied Date], a.ApplyRefNbr AS [Applied Reference Number], 
     a.BatSeq AS [Batch Sequence], a.ClearAmt AS [Cleared Amount], 
     convert(date,a.ClearDate) AS [ClearDate], convert(date,a.Crtd_DateTime) AS [Create Date], a.Crtd_Prog AS [Create Program], a.Crtd_User AS [Create User], 
     a.CurrentNbr AS [Current Number], a.CuryDiscBal AS [Currency Discount Balance], a.CuryDiscTkn AS [Currency Discount Taken], a.CuryDocBal AS [Currency Document Balance], 
     convert(date,a.CuryEffDate) AS [Currency Effective Date], a.CuryId AS [Currency ID], a.CuryMultDiv AS [Currency Multiply/Divide], a.CuryOrigDocAmt AS [Currency Original Document Balance], 
     a.CuryPmtAmt AS [Currency Payment Amount], a.CuryRate AS [Currency Rate], 
     a.CuryRateType AS [Currency Rate Type], 
     a.CuryTaxTot00 AS [Currency Tax Total 01], a.CuryTaxTot01 AS [Currency Tax Total 02], a.CuryTaxTot02 AS [Currency Tax Total 03], a.CuryTaxTot03 AS [Currency Tax Total 04], 
     a.CuryTxblTot00 AS [Currency Taxable Total 01], a.CuryTxblTot01 AS [Currency Taxable Total 02], a.CuryTxblTot02 AS [Currency Taxable Total 03],a.CuryTxblTot03 AS [Currency Taxable Total 04], a.Cycle, 
     a.DiscBal [Discount Balance], a.DiscTkn AS [Discount Taken], 
     a.DocClass AS [Document Class], a.ExcludeFreight, 
     a.FreightAmt AS [Freight Amount], a.InstallNbr AS [Installment Number],a.LCCode AS [Landed Cost Code], 
     a.LineCntr AS [Line Counter], convert(date,a.LUpd_DateTime) AS [Last Update Date], a.LUpd_Prog AS [Last Update Program], a.LUpd_User AS [Last Update User], a.MasterDocNbr AS [Master Document Number], 
     a.NbrCycle AS [Number of Cycles], a.NoteID, a.OpenDoc AS [Open Document],  
     a.PC_Status AS [Project Controller Status], a.PerClosed AS [Period Closed], a.PerEnt AS [Period Entered], a.PerPost AS [Period to Post], 
     a.PmtAmt AS [Payment Amount], a.PmtID AS [Payment ID], a.PmtMethod AS [Payment Method], a.PrePay_RefNbr AS [Prepayment Reference Number], 
     a.ProjectID, a.RecordID, Retention, a.RGOLAmt AS [Realized Gain/Loss Amount], 
     a.S4Future01 AS [Master Document(Distributed Liability) Company ID], a.S4Future02 AS [Purchasing Receipt Number], a.S4Future11 AS [Master Document Type], a.S4Future12 AS [Master Document Reference Number], a.Selected,  
     a.Sub AS [Subaccount], a.Subcontract, a.TaxCntr00 AS [Tax Counter 01], a.TaxCntr01 AS [Tax Counter 02], a.TaxCntr02 AS [Tax Counter 03],TaxCntr03 AS [Tax Counter 04], 
     a.TaxId00, a.TaxId01, a.TaxId02, a.TaxId03, 
     a.TaxTot00 AS [Tax Total 01], a.TaxTot01 AS [Tax Total 02], a.TaxTot02 AS [Tax Total 03], a.TaxTot03 AS [Tax Total 04], 
     a.TxblTot00 AS [Taxable Total 01], a.TxblTot01 AS [Taxable Total 02], a.TxblTot02 AS [Taxable Total 03], a.TxblTot03 AS [Taxable Total 04], 
     a.User1, a.User2, a.User3, a.User4, a.User5, a.User6, convert(date,a.User7) AS [User7], convert(date,a.User8) AS [User8]
FROM    APdoc a with (nolock)
        INNER JOIN vendor v with (nolock) ON a.VendID = v.VendId
WHERE	a.DocType = 'RC'



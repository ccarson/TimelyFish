
CREATE VIEW [dbo].[QQ_ardoc_recur]
AS
SELECT     
     a.BatNbr AS [Batch Number], a.Rlsed AS [Released], a.Status AS [Batch Status],a.RefNbr As [Reference Number], a.CustId AS [Customer ID],
     CASE WHEN CHARINDEX('~', C.Name) > 0 THEN CONVERT(CHAR(60), 
	 LTRIM(SUBSTRING(C.Name, 1, CHARINDEX('~',C.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX('~',C.Name) + 1, 60)))) ELSE C.Name END AS [Customer Name], 
     a.OrigDocAmt AS [Original Document Amount] , a.DocBal AS [Document Balance], a.DocType AS [Document Type], a.DocDesc AS [Document Description], 
     a.CpnyID AS [Company ID],  a.BankAcct AS [Bank Account],a.BankSub AS [Bank Subaccount],
     a.AcctNbr AS [Account Number], a.ApplAmt AS [Applied Amount],
     a.ApplBatNbr AS [Applied Batch Number], a.ApplBatSeq AS [Applied Batch Sequence],  
     a.BatSeq AS [Batch Sequence], convert(date,a.Cleardate) AS [ClearDate], a.CmmnAmt AS [Commission Amount], a.CmmnPct [Commission Percent], a.ContractID, 
     convert(date,a.Crtd_DateTime) AS [Create Date], a.Crtd_Prog AS [Created Program], a.Crtd_User AS [Created User], a.CurrentNbr AS [Current Period Document], 
     a.CuryApplAmt AS [Currency Applied Amount], a.CuryClearAmt AS [Currency Cleared Amount], a.CuryCmmnAmt AS [Currency Commission Amount], a.CuryDiscApplAmt AS [Currency Discount Applied Amount],
     a.CuryDiscBal AS [Currency Discount Balance],a.CuryDocBal AS [Currency Document Balance], 
     convert(date,a.CuryEffDate) AS [Currency Effective Date], a.CuryId AS [Currency ID], a.CuryMultDiv AS [Currency Multiply/Divide], a.CuryOrigDocAmt AS [Currency Original Document Amount], 
     a.CuryRate AS [Currency Rate], a.CuryRateType AS [Currency Rate Type], a.CuryStmtBal AS [Currency Statment Balance], a.CuryTaxTot00 AS [Currency Tax Total 01], a.CuryTaxTot01 AS [Currency Tax Total 02], 
     a.CuryTaxTot02 AS [Currency Tax Total 03], a.CuryTaxTot03 AS [Currency Tax Total 04], a.CuryTxblTot00 AS [Currency Taxable Total 01], a.CuryTxblTot01 AS [Currency Taxable Total 02], a.CuryTxblTot02 AS [Currency Taxable Total 03], 
     a.CuryTxblTot03 AS [Currency Taxable Total 04], a.CustOrdNbr AS [Customer Order Number], a.Cycle, a.DiscApplAmt AS [Discount Applied Amount], 
     a.DiscBal AS [Discount Balance], convert(date,a.DiscDate) AS [Discount Date], a.DocClass AS [Document Class], convert(date,a.DocDate) AS [Document Date], 
     convert(date,a.DueDate) AS [DueDate], a.InstallNbr AS [Installment number], 
     convert(date,a.LUpd_DateTime) AS [Last Update Date], a.LUpd_Prog AS [Last Updated Program], a.LUpd_User AS [Last Updated User], 
     a.MasterDocNbr AS [Original Invoice Number], a.NbrCycle AS [Number of Cycles], a.NoPrtStmt AS [Document Reversal], a.NoteId, a.OpenDoc AS [Open Document], 
     a.OrdNbr AS [Order Number], a.OrigBankAcct AS [Original Bank Account], a.OrigBankSub AS [Original Bank Subaccount], a.OrigCpnyID AS [Original Company ID],  
     a.OrigDocNbr AS [Original Document Number], a.PC_Status AS [Project Controller Status], a.PerClosed AS [Period Closed], a.PerEnt AS [Period Entered], a.PerPost AS [Period Posted], 
     a.PmtMethod AS [Payment Method], a.ProjectID, a.RGOLAmt AS [Realized Gain/Loss Amount],  
     a.ServiceCallID, a.ShipmentNbr AS [Shipment Number], a.SlsperId AS [Salesperson ID], 
     a.StmtBal AS [Statement Balance], convert(date,a.StmtDate) AS [Statement Date],a.TaxCntr00 AS [Tax Counter 01], 
     a.TaxCntr01 AS [Tax Counter 02], a.TaxCntr02 AS [Tax Counter 03], a.TaxCntr03 AS [Tax Counter 04], a.TaxId00 AS [Tax ID 01], a.TaxId01 AS [Tax ID 02], 
     a.TaxId02 AS [Tax ID 03], a.TaxId03 AS [Tax ID 04], a.TaxTot00 AS [Tax Total 01], a.TaxTot01 AS [Tax Total 02], a.TaxTot02 AS [Tax Total 03], 
     a.TaxTot03 AS [Tax Total 04], a.Terms, a.TxblTot00 AS [Taxable Total 01], a.TxblTot01 AS [Taxable Total 02], a.TxblTot02 AS [Taxable Total 03], 
     a.TxblTot03 AS [Taxable Total 04], a.User1, a.User2, a.User3, a.User4, 
     a.User5, a.User6, convert(date,a.User7) AS [User7], convert(date,a.User8) AS [User8], a.WSID AS [Application Server Identification Code]
FROM    Ardoc a with (nolock)
        INNER JOIN customer c with (nolock) ON a.CustID = c.CustId
WHERE	a.DocType = 'RC'


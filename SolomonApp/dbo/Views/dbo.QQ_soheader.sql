
CREATE VIEW [QQ_soheader]
AS
SELECT		h.OrdNbr AS [Order Number], convert(date,h.OrdDate) AS [Order Date], h.CustOrdNbr AS [Customer Order Number], h.CustID AS [Customer ID], 
		CASE WHEN CHARINDEX('~', c.Name) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(c.Name, 1, CHARINDEX('~', c.Name) - 1)) + ', ' + 
		LTRIM(RTRIM(SUBSTRING(c.Name, CHARINDEX('~', c.Name) + 1, 60)))) ELSE c.Name END AS [Customer Name], h.SOTypeID AS [Sales Order Type ID], h.Status, 
		isnull(SOStep.Descr,'') AS [Next Step], h.TotOrd AS [Order Total], h.BalDue AS [Balance Due], h.InvcNbr AS [Invoice Number], 
		convert(date,h.InvcDate) AS [Invoice Date], h.Cancelled, h.CpnyID AS [Company ID], h.S4Future12 AS [Address Type], h.AdminHold AS [Administrative Hold], 
		h.S4Future01 AS [Applied To Document Reference Number], h.ApprDetails AS [Details Approval], h.ApprRMA AS [RMA Approval], h.ApprTech AS 
		[Technical Details Approval], h.ARAcct AS [A/R Account], h.ARSub AS [A/R Subaccount], h.ASID, h.ASID01, h.AuthNbr AS [Authorization Number], h.AutoPO AS 
		[Auto Create Purchase Order], h.AutoPOVendID AS [Auto PO Vendor ID], h.AwardProbability, h.BIInvoice AS [Invoicing Location], h.BillAddr1 AS 
		[Bill To Address 1], h.BillAddr2 AS [Bill To Address 2], h.BillAddrSpecial AS [Bill To Address Special], h.BillAttn AS [Bill To Attention], h.BillCity AS 
		[Bill To City], h.BillCountry AS [Bill To Country], h.BillName AS [Bill To Name], 
		'(' + SUBSTRING(h.BillPhone, 1, 3) + ')' + SUBSTRING(h.BillPhone, 4, 3) + '-' + RTRIM(SUBSTRING(h.BillPhone, 7, 24)) AS [Bill To Phone], 
		h.BillState AS [Bill To State/Province], h.BillZip AS [Bill To Zip/Postal Code], h.BlktOrdNbr AS [Blanket Order Number], h.BuildAssyTime AS 
		[Build Assembly Time], convert(date,h.BuildAvailDate) AS [Build Available Date], h.BuildInvtID AS [Build Inventory ID], h.BuildQty AS [Build Quantity], 
		h.S4Future03 AS [Build Quantity Updated], h.BuildSiteID, h.BuyerID, h.BuyerName, convert(date,h.CancelDate) AS [CancelDate], h.CancelShippers, h.CertID AS 
		[Certification ID], h.CertNoteID AS [Certification Note ID], h.ChainDisc AS [Chain Discount], h.CmmnPct AS [Commission Percent], h.ConsolInv AS 
		[Consolidated Invoice], h.ContractNbr AS [Contract Number], h.CreditApprDays AS [Credit Approval Days], h.CreditApprLimit AS [Credit Approval Limit], 
		h.CreditChk AS [Credit Checking], h.CreditHold AS [Credit Hold], convert(date,h.CreditHoldDate) AS [CreditHoldDate], convert(date,h.Crtd_DateTime) AS 
		[Create Date], h.Crtd_Prog AS [Create Program], h.Crtd_User AS [Create User], h.CuryBalDue AS [Currency Balance Due], 
		convert(date,h.CuryEffDate) AS [Currency Effective Date], h.CuryID AS [Currency ID], h.CuryMultDiv AS [Currency Multiply or Divide], 
		h.S4Future04 AS [Currency Premium Freight Amount Applied], h.CuryRate AS [Currency Rate], h.CuryRateType AS [Currency Rate Type], 
		h.CuryTotFrt AS [Currency Total Freight], h.CuryTotLineDisc AS [Currency Total Line Discount], h.CuryTotMerch AS [Currency Total Merchandise], 
		h.CuryTotMisc AS [Currency Total Miscellaneous], h.CuryTotOrd AS [Currency Total Order], h.CuryTotPremFrt AS [Currency Total Premium Freight], 
		h.CuryTotTax AS [Currency Total Tax], h.CuryUnshippedBalance AS [Currency Unshipped Balance], h.CuryWholeOrdDisc AS [Currency Whole Order Discount], 
		h.CustGLClassID AS [Customer GL Class ID], convert(date,h.DateCancelled) AS [DateCancelled], h.Dept AS Department, h.DiscAcct AS [Discount Account], 
		h.DiscSub AS [Discount Subaccount], h.DiscPct AS [Discount Percent], h.Div AS Division, h.DropShip, h.EDI810 AS [EDI Invoice], h.EDI856 AS 
		[EDI Advanced Ship Notice], h.EDIPOID AS [EDI Purchase Order ID], h.FOBID, h.FrtAcct AS [Freight Account], h.FrtSub AS [Freight Subaccount], h.FrtCollect AS 
		[Freight Collect],  h.FrtTermsID AS [Freight Terms ID], h.IRDemand AS [Inventory Replenishment Demand], h.LanguageID, h.LostSaleID, 
		convert(date,h.LUpd_DateTime) AS [Last Update Date],h.LUpd_Prog AS [Last Update Program], h.LUpd_User AS [Last Update User], h.MarkFor, h.NextFunctionClass, 
		h.NextFunctionID, h.NoteId, h.OrigOrdNbr AS [Original Order Number], h.PC_Status AS [Project Controller Status], h.PerPost AS [Period to Post], 
		h.S4Future05 AS [Premium Freight Amount Applied], h.Priority, h.ProjectID, convert(date,h.QuoteDate) AS [QuoteDate], h.Released, h.ReleaseValue, 
		h.RequireStepAssy AS [Require Step Assembly], h.RequireStepInsp AS [Require Step Inspection], h.RlseForInvc AS [Release for Invoicing], h.S4Future09 AS 
		[DropShip/Nonstock], h.SellingSiteID, h.S4Future02 AS [Siebel Front Office Order Number], h.ShipAddr1 AS [Ship To Address 1], h.ShipAddr2 AS 
		[Ship To Address 2], h.ShipAddrID AS [Ship To Address ID], h.ShipAddrSpecial AS [Ship To Address Special], h.ShipAttn AS [Ship To Attention], h.ShipCity AS 
		[Ship To City], h.ShipCmplt AS [Ship Complete], h.ShipCountry AS [Ship To Country], h.ShipCustID AS [Ship To Customer ID], h.ShipName AS [Ship To Name], 
		'(' + SUBSTRING(h.ShipPhone, 1, 3) + ')' + SUBSTRING(h.ShipPhone, 4, 3) + '-' + RTRIM(SUBSTRING(h.ShipPhone, 7, 24)) AS [Ship To Phone], 
		h.ShipSiteID AS [Ship To Site ID], h.ShipState AS [Ship To State], h.ShiptoID, h.ShiptoType, h.ShipVendID AS [Ship To Vendor ID], h.ShipViaID, 
		h.ShipZip AS [Ship To Zip], h.SlsperID AS [Salesperson ID], h.TaxID00, h.TaxID01, h.TaxID02, h.TaxID03, h.TermsID, h.TotCommCost AS 
		[Total Commissionable Cost], h.TotCost AS [Total Cost], h.TotFrt AS [Total Freight], h.TotLineDisc AS [Total Line Discount], h.TotMerch AS [Total Merchandise], 
		h.TotMisc AS [Total Miscellaneous], h.TotPremFrt AS [Total Premium Freight], h.TotShipWght AS [Total Shipment Weight], h.TotTax AS [Total Tax],
		h.UnshippedBalance, h.S4Future11 AS [Vendor Address ID], h.WeekendDelivery, h.WholeOrdDisc AS [Whole Order Discount], h.WorkflowID, h.WorkflowStatus, h.WSID,
		h.User1, h.User2, h.User3, h.User4, h.User5, h.User6, h.User7, h.User8, convert(date,h.User9) AS [User9], convert(date,h.User10) AS [User10]
		
FROM	SOHeader h with (nolock)
					LEFT OUTER JOIN SOStep with (nolock) ON h.SOTypeID = SOStep.SOTypeID AND h.CpnyID = SOStep.CpnyID AND 
                      h.NextFunctionClass = SOStep.FunctionClass AND h.NextFunctionID = SOStep.FunctionID 
					LEFT OUTER JOIN Customer c with (nolock) ON h.CustID = c.CustId


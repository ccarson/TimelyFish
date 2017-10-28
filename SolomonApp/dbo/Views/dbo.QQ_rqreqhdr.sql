
CREATE VIEW [QQ_rqreqhdr]
AS
SELECT     H.CpnyID AS [Company ID], H.ReqNbr AS [Requisition Number], H.VendID AS [Vendor ID], CASE WHEN CHARINDEX('~' , V.Name) > 0 THEN CONVERT (CHAR(60) , 
		LTRIM(SUBSTRING(V.Name, 1 , CHARINDEX('~' , V.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(V.Name, CHARINDEX('~' , V.Name) + 1 , 60)))) ELSE V.Name END AS 
		[Vendor Name], H.Budgeted, H.Dept AS Department, H.Descr AS [Description], H.DocHandling AS [Document Handling], H.PONbr AS [Purchase Order Number], 
		H.Project, H.RcptTotAmt AS [Receipt Total Amount], H.ReqTotal AS [Requisition Total], H.TotalExtCost AS [Total Extended Cost], H.Acct AS Account, 
		CONVERT(DATE,H.AckDateTime) AS [Acknowledged Date], H.Addr1 AS [Address 1], H.Addr2 AS [Address 2], H.AppvLevObt AS [Approval Level Obtained], 
		H.AppvLevReq AS [Approval Level Required], CASE WHEN CHARINDEX('~' , H.Attn) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(H.Attn, 1 , 
		CHARINDEX('~' , H.Attn) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(H.Attn, CHARINDEX('~' , H.Attn) + 1 , 60)))) ELSE H.Attn END AS Attention, H.BatNbr AS 
		[Batch Number], H.BillAddrID AS [Bill To Address ID], H.BillAddr1 AS [Bill To Address 1], H.BillAddr2 AS [Bill To Address 2], CASE WHEN CHARINDEX('~' , H.BillAttn) 
		> 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(H.BillAttn, 1 , CHARINDEX('~' , H.BillAttn) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(H.BillAttn, CHARINDEX('~' , H.BillAttn) 
		+ 1 , 60)))) ELSE H.BillAttn END AS [Bill To Attention], H.BillCity AS [Bill To City], H.BillCountry AS [Bill To Country/Region], H.BillEmail AS 
		[Bill To Email], '(' + SUBSTRING(H.BillFax, 1, 3) + ')' + SUBSTRING(H.BillFax, 4, 3) + '-' + RTRIM(SUBSTRING(H.BillFax, 7, 24)) AS [Bill To Fax/Ext], 
		H.BillName AS [Bill To Name], '(' + SUBSTRING(H.BillPhone, 1, 3) + ')' + SUBSTRING(H.BillPhone, 4, 3) + '-' + RTRIM(SUBSTRING(H.BillPhone, 7, 24)) AS 
		[Bill To Phone/Ext], H.BillShipAddr AS [Bill To Ship Address], H.BillState AS [Bill To State/Province], H.BillZip AS [Bill To Zip/Postal Code], 
		CONVERT(DATE,H.BlktExpDate) AS [Blanket Expiration Date], H.BlktNbr AS [Blanket Number], H.Buyer, H.CertCompl AS [Certificate of Compliance], H.City, 
		H.ConfirmTo, H.Country AS [Country/Region], CONVERT(DATE,H.CreateDate) AS [CreateDate], CONVERT(DATE,H.crtd_datetime) AS [Create Date], H.crtd_prog AS 
		[Create Program], H.crtd_user AS [Create User], H.CurrentNbr, CONVERT(DATE,H.CuryEffdate) AS [Currency Effective Date], H.CuryFreight AS 
		[Currency Freight Amount], H.CuryID AS [Currency ID], H.CuryMultDiv AS [Currency Multiply/Divide], H.CuryPOItemTotal AS [Currency Purchase Order Item Total], 
		H.CuryPrevPoTotal AS [Currency Previous Purchase Order Total], H.CuryRate AS [Currency Rate], 
		H.CuryRateType AS [Currency Rate Type], H.CuryRcptTotAmt AS [Currency Receipt Total Amount], H.CuryReqTotal AS [Currency Requisition Total], H.CuryTaxTot00 
		AS [Currency Tax Total 01], H.CuryTaxTot01 AS [Currency Tax Total 02], H.CuryTaxTot02 AS [Currency Tax Total 03], H.CuryTaxTot03 AS [Currency Tax Total 04], 
		H.CuryTotalExtCost AS [Currency Total Extended Cost], H.CuryTxblTot00 AS [Currency Taxable Total 01], H.CuryTxblTot01 AS [Currency Taxable Total 02], 
		H.CuryTxblTot02 AS [Currency Taxable Total 03], H.CuryTxblTot03 AS [Currency Taxable Total 04], H.EDI, H.EncumProc, '(' + SUBSTRING(H.Fax, 1, 3) + ')' + 
		SUBSTRING(H.Fax, 4, 3) + '-' + RTRIM(SUBSTRING(H.Fax, 7, 24)) AS [Fax/Ext], H.FOB, H.Freight, CONVERT(DATE,H.lupd_datetime) AS [Last Update Date], 
		H.lupd_prog AS [Last Update Program], H.lupd_user AS [Last Update User], H.MaterialType, H.Name, H.NoteID, H.OptA AS [Special Handling Option A], 
		H.OptB AS [Special Handling Option B], H.OptC AS [Special Handling Option C], H.PC_Status AS [Project Status], H.PerApproved AS [Period Approved], 
		H.PerEntered AS [Period Entered], '(' + SUBSTRING(H.Phone, 1, 3) + ')' + SUBSTRING(H.Phone, 4, 3) + '-' + RTRIM(SUBSTRING(H.Phone, 7, 24)) AS [Phone/Ext], 
		CONVERT(DATE,H.PODate) AS [Purchase Order Date], H.POItemTotal AS [Purchase Order Item Total], H.PolicyLevObt AS [Policy Approval Level Obtained], 
		H.PolicyLevReq AS [Policy Approval Level Required], H.POType AS [Purchase Order Type], H.PrevPoTotal AS [Previous Purchase Order Total], 
		CONVERT(DATE,H.QuoteDate) AS [QuoteDate], H.ReqCntr AS [Requisition Counter], H.ReqType AS [Requisition Type], H.Requstnr AS Requester, H.RequstnrDept 
		AS [Requester Department], H.RequstnrName AS [Requester Name], H.S4Future1, H.S4Future2, H.S4Future3, H.S4Future4, H.S4Future5, H.S4Future6, 
		CONVERT(DATE,H.S4Future7) AS [S4Future07], CONVERT(DATE,H.S4Future8) AS [S4Future08], H.S4Future9, H.S4Future10, H.S4Future11, H.S4Future12, H.ServiceCallID, 
		H.ShipAddr1 AS [Shipping Address 1], H.ShipAddr2 AS [Shipping Address 2], H.ShipAddrID AS [Shipping Address ID], H.ShipAttn AS [Shipping Address Attention], 
		H.ShipCity AS [Shipping Address City], H.ShipCountry AS [Shipping Address Country/Region], H.ShipCustID AS [Shipping Address Customer ID], H.ShipEmail 
		AS [Shipping Address Email Address], '(' + SUBSTRING(H.ShipFax, 1, 3) + ')' + SUBSTRING(H.ShipFax, 4, 3) + '-' + RTRIM(SUBSTRING(H.ShipFax, 7, 24))
        AS [Shipping Address Fax/Ext], H.ShipName AS [Shipping Address Name], '(' + SUBSTRING(H.ShipPhone, 1, 3) + ')' + SUBSTRING(H.ShipPhone, 4, 3) + '-' + 
        RTRIM(SUBSTRING(H.ShipPhone, 7, 24)) AS [Shipping Address Phone/Ext], H.ShipSiteID AS [Shipping Address Site ID], H.ShipState AS 
        [Shipping Address State/Region], H.ShipToID, H.ShipToType, H.ShipVendAddrID AS [Shipping Vendor Address ID], H.ShipVendID AS [Shipping Vendor ID], 
        H.ShipVia, H.ShipZip AS [Shipping Zip/Postal Code], H.State AS [State/Region], H.Status, H.Sub AS Subaccount, H.Task, H.TaxCntr00 AS [Tax Counter 01], 
        H.TaxCntr01 AS [Tax Counter 02], H.TaxCntr02 AS [Tax Counter 03], H.TaxCntr03 AS [Tax Counter 04], H.TaxID00 AS [Tax ID 01], H.TaxID01 AS [Tax ID 02], 
        H.TaxID02 AS [Tax ID 03], H.TaxID03 AS [Tax ID 04], H.TaxTot00 AS [Tax Total 01], H.TaxTot01 AS [Tax Total 02], H.TaxTot02 AS [Tax Total 03], H.TaxTot03 
        AS [Tax Total 04], H.Terms, H.TranMedium AS [Transaction Medium], H.TxblTot00 AS [Taxable Total 01], H.TxblTot01 AS [Taxable Total 02], H.TxblTot02 AS 
        [Taxable Total 03], H.TxblTot03 AS [Taxable Total 04], H.User1, H.User2, H.User3, H.User4, H.User5, H.User6, CONVERT(DATE,H.User7) AS [User7], 
        CONVERT(DATE,H.User8) AS [User8], H.VendAddrID AS [Vendor Address ID], H.VendEmail AS [Vendor Email Address], H.VouchStage AS [Vouchered Stage], 
        H.Zip AS [Zip/Postal Code]
FROM         RQReqHdr H with (nolock) 
		LEFT OUTER JOIN Vendor V with (nolock) ON H.VendID = V.VendId



CREATE VIEW [QQ_purchord]
AS
SELECT		CpnyID AS [Company ID], PONbr AS [PO Number], convert(date,PODate) AS [Date], POType AS [Type], VendID AS [Vendor ID], 
			CASE WHEN CHARINDEX('~' , VendName) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(VendName, 1 , CHARINDEX('~' , VendName) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(VendName, 
			CHARINDEX('~' , VendName) + 1 , 60)))) ELSE VendName END AS [Vendor Name], PerEnt AS [Period Entered], PerClosed AS [Period Closed], POItemTotal, POAmt AS [PO Total], 
			RcptTotAmt AS [Total Received], Status, OpenPO, RcptStage AS [Receipt Stage], VouchStage AS [Vouchered Stage], ProjectID, convert(date,AckDateTime) AS [Date Acknowledged], ASID, 
			BatNbr AS [Batch Number], BillShipAddr AS [Bill Ship Address], convert(date,BlktExprDate) AS [Blanket PO Expiration Date], BlktPONbr AS [Blanket PO Number], Buyer, BuyerEmail, 
			CertCompl AS [Certificate of Compliance], ConfirmTo, convert(date,Crtd_DateTime) AS [Create Date], Crtd_Prog AS [Create Program], Crtd_User AS [Create User], 
			CurrentNbr AS [Current Number], convert(date,CuryEffDate) AS [Currency Effective Date], CuryFreight AS [Currency Freight Amount], CuryID AS [Currency ID], 
			CuryMultDiv AS [Currency Multiply/Divide], CuryPOAmt AS [Currency PO Amount], CuryPOItemTotal AS [Currency PO Item Total], CuryRate AS [Currency Rate], 
			CuryRateType AS [Currency Rate Type], CuryRcptTotAmt AS [Currency Receipt Total Amount], CuryTaxTot00 AS [Currency Tax Total 01], CuryTaxTot01 AS [Currency Tax Total 02], 
			CuryTaxTot02 AS [Currency Tax Total 03], CuryTaxTot03 AS [Currency Tax Total 04], CuryTxblTot00 AS [Currency Taxable Total 01], CuryTxblTot01 AS [Currency Taxable Total 02], 
			CuryTxblTot02 AS [Currency Taxable Total 03], CuryTxblTot03 AS [Currency Taxable Total 04], EDI, FOB, Freight AS [Freight Amount], convert(date,LastRcptDate) AS [Last Received Date], 
			convert(date,LUpd_DateTime) AS [Last Update Date], LUpd_Prog AS [Last Update Program], LUpd_User AS [Last Update User], NoteID, PC_Status AS [Project Controller Status], 
			PrtBatNbr AS [Print Batch Number], PrtFlg AS [Print Flag], ReqNbr, S4Future11 AS [Ship To Source], ServiceCallID, ShipAddr1 AS [Ship To Address 1], 
			ShipAddr2 AS [Ship To Address 2], ShipAddrID AS [Ship To Address ID], ShipAttn AS [Ship To Attention], ShipCity AS [Ship To City], ShipCountry AS [Ship To Country/Region], 
			ShipCustID AS [Ship To Customer ID], ShipEmail AS [Ship To Email], ShipFax AS [Ship To Fax], CASE WHEN CHARINDEX('~' , ShipName) > 0 THEN CONVERT (CHAR(60) , 
			LTRIM(SUBSTRING(ShipName, 1 , CHARINDEX('~' , ShipName) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(ShipName, CHARINDEX('~' , ShipName) + 1 , 60)))) ELSE ShipName END AS [Ship To Name], 
			'(' + SUBSTRING(ShipPhone, 1, 3) + ')' + SUBSTRING(ShipPhone, 4, 3) + '-' + RTRIM(SUBSTRING(ShipPhone, 7, 24)) AS [Ship To Phone], ShipSiteID AS [Ship To Site ID], 
			ShipState AS [Ship To State], ShiptoID, ShiptoType, ShipVendAddrID AS [Ship To Vendor Address ID], ShipVendID AS [Ship To Vendor ID], ShipVia, ShipZip AS [Ship To Postal Code], 
			TaxCntr00 AS [Tax Counter 01], TaxCntr01 AS [Tax Counter 02], TaxCntr02 AS [Tax Counter 03], TaxCntr03 AS [Tax Counter 04], TaxID00 AS [Tax ID 01], TaxID01 AS [Tax ID 02], 
			TaxID02 AS [Tax ID 03], TaxID03 AS [Tax ID 04], TaxTot00 AS [Tax Total 01], TaxTot01 AS [Tax Total 02], TaxTot02 AS [Tax Total 03], TaxTot03 AS [Tax Total 04], Terms, 
			TxblTot00 AS [Taxable Total 01], TxblTot01 AS [Taxable Total 02], TxblTot02 AS [Taxable Total 03], TxblTot03 AS [Taxable Total 04], User1, User2, User3, User4, User5, User6, 
			convert(date,User7) AS [User7], convert(date,User8) AS [User8], VendAddr1 AS [Vendor Address 1], VendAddr2 AS [Vendor Address 2], VendAddrID AS [Vendor Address ID], VendAttn AS [Vendor Attention], VendCity AS [Vendor City], 
			VendCountry AS [Vendor Country/Region], VendEmail AS [Vendor Email], VendFax AS [Vendor Fax], '(' + SUBSTRING(VendPhone, 1, 3) + ')' + SUBSTRING(VendPhone, 4, 3) + '-' + 
			RTRIM(SUBSTRING(VendPhone, 7, 24)) AS [Vendor Phone], VendState AS [Vendor State], VendZip AS [Vendor Postal Code], WSID
FROM         PurchOrd with (nolock)


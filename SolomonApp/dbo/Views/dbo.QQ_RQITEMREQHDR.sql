 
CREATE VIEW [QQ_RQITEMREQHDR]
AS
SELECT      
	r.CpnyID AS [Company ID], r.Dept AS [Department], r.ItemReqNbr AS [Item Request Number], r.IrTotal AS [Item Request Total],
	CASE WHEN CHARINDEX('~', d.DfltDelivAttn) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(d.DfltDelivAttn, 1, CHARINDEX('~', d.DfltDelivAttn) - 1)) + ', ' + 
	LTRIM(RTRIM(SUBSTRING(d.DfltDelivAttn, CHARINDEX('~', d.DfltDelivAttn) + 1, 60)))) ELSE d.DfltDelivAttn END 'Attention',
	'(' + SUBSTRING(d.DfltDelivPhone, 1, 3) + ')' + SUBSTRING(d.DfltDelivPhone, 4, 3) + '-' + RTRIM(SUBSTRING(d.DfltDelivPhone, 7, 24)) AS [Phone/Ext], 
	r.VendID AS [Vendor ID], CASE WHEN CHARINDEX('~', v.name) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(v.name, 1, CHARINDEX('~', v.name) - 1)) + ', ' + 
	LTRIM(RTRIM(SUBSTRING(v.name, CHARINDEX('~', v.name) + 1, 60)))) ELSE V.name END 'Vendor Name',
	r.Requstnr AS [Requester], CASE WHEN CHARINDEX('~', r.RequstnrName) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(r.RequstnrName, 1, CHARINDEX('~', 
	r.RequstnrName) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(r.RequstnrName, CHARINDEX('~', r.RequstnrName) + 1, 60)))) ELSE r.RequstnrName END as [Name of Requester],
	r.MaterialType AS [Material Type], r.Status AS [Status], r.Acct AS [Expense Account], r.AppvLevObt AS [Approval Obtained], r.AppvLevReq AS [Approval Required], 
	r.BillAddr1 AS [Bill Address 1], r.BillAddr2 AS [Bill Address 2], r.BillAttn  AS [Billing Attention], r.BillCity AS [Billing City], r.BillCountry AS 
	[Billing Country/Region], r.BillEmail AS [Billing Email Address], r.BillFax AS [Billing Fax/Ext], r.BillName AS [Billing Name], 
	'(' + SUBSTRING(r.BillPhone, 1, 3) + ')' + SUBSTRING(r.BillPhone, 4, 3) + '-' + RTRIM(SUBSTRING(r.BillPhone, 7, 24)) AS [Billing Phone/Ext], 
	r.BillState AS [Billing State/Province], r.BillZip AS [Billing Postal Code], r.City AS [City], r.Country AS [Country], convert(date,r.CreateDate) AS [Created Date], 
	convert(date,r.crtd_datetime) AS [Create Date], r.crtd_prog AS [Create Program], r.crtd_user AS [Create User], r.CuryEffDate AS [Currency Effective Date], 
	r.CuryFreight AS [Currency Freight Amount], r.CuryID AS [Currency ID], r.CuryIRTotal AS [Currency Item Request Total Amount], r.CuryMultDiv AS 
	[Currency Mulitply/Divide], r.CuryRate AS [Currency Rate], r.CuryRateType AS [Currency Rate Type], r.CuryTaxTot00 AS [Currency Tax Total 1], r.CuryTaxTot01 AS 
	[Currency Tax Total 2], r.CuryTaxTot02 AS [Currency Tax Total 3], r.CuryTaxTot03 AS [Currency Tax Total 4], r.CuryTxblTot00 AS [Currency Taxable Total 1], 
	r.CuryTxblTot01 AS [Currency Taxable Total 2], r.CuryTxblTot02 AS [Currency Taxable Total 3], r.CuryTxblTot03 AS [Currency Taxable Total 4], 
	r.Descr AS [Description], r.DocHandling AS [Document Handling], convert(date,r.lupd_datetime) AS [Last Update Date], r.lupd_prog AS [Last Update Program], 
	r.lupd_user AS [Last Update User], r.NoteId AS [Note ID], r.OptA AS [Option A], r.OptB AS [Option B], r.OptC AS [Option C], r.PolicyLevObt AS 
	[Policy Level Obtained], r.PolicyLevReq AS [Policy Level Required], r.Project AS [Project], r.RequstnrDept AS [Department of Requester], 
	r.shipaddrid AS [Shipping Address ID], r.ShipAddr1 AS [Shipping Address 1], r.ShipAddr2 AS [Shipping Address 2], r.ShipAttn AS [Shipping Attention], 
	r.ShipCity AS [Shipping City], r.ShipCountry AS [Shipping Country], r.ShipCustID AS [Shipping Customer ID], r.ShipEmail AS [Shipping Email], 
	r.ShipFax AS [Shipping Fax],r.ShipName AS [Shipping Name], r.ShipOrdFromID AS [Ship Order From ID],
	'(' + SUBSTRING(r.ShipPhone, 1, 3) + ')' + SUBSTRING(r.ShipPhone, 4, 3) + '-' + RTRIM(SUBSTRING(r.ShipPhone, 7, 24)) AS [Shipping Phone],
	r.ShipSiteID AS [Shipping Site ID], r.ShipState AS [Shipping State], r.ShipToID, r.ShipToTye AS [Shipping Address Type], r.ShipVendID AS [Shipping Vendor ID], 
	r.ShipZip AS [Shipping Postal Code], r.State, r.Sub AS [Expense Subaccount], r.Task AS [Task], r.User1 AS [User1], r.User2 AS [User2], r.User3 AS [User3], 
	r.User4 AS [User4], r.User5 AS [User5], r.User6 AS [User6], convert(date,r.User7) AS [User7], convert(date,r.User8) AS [User8], r.Zip AS [Postal Code]

FROM         RQItemReqHdr r with (nolock)
				left outer join RQDept d with (nolock) on r.Dept = d.DeptID
				left outer join Vendor v with (nolock) on r.VendID = v.VendId
  

 
CREATE VIEW [QQ_RQITEMREQDET]
AS
SELECT  
rd.ItemReqNbr AS [Item Request Number], rd.LineKey AS [Line Key], rd.Status AS [Status],rd.PurchaseFor AS [Purchase For],rd.Dept AS [Department], 
d.DfltDelivAttn AS [Attention], 
'(' + SUBSTRING(d.DfltDelivPhone, 1, 3) + ')' + SUBSTRING(d.DfltDelivPhone, 4, 3) + '-' + RTRIM(SUBSTRING(d.DfltDelivPhone, 7, 24)) AS [Phone],
rd.Qty AS [Quantity], rd.Unit AS [UOM], rd.TotalCost AS [Total Cost], rd.InvtID AS [Inventory ID], rd.Descr as [Description], 
CASE WHEN CHARINDEX('~', r.RequstnrName) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(r.RequstnrName, 1, CHARINDEX('~', r.RequstnrName) - 1)) + ', ' + 
	LTRIM(RTRIM(SUBSTRING(r.RequstnrName, CHARINDEX('~', r.RequstnrName) + 1, 60)))) ELSE r.RequstnrName END AS [Requester Name],
CASE WHEN CHARINDEX('~', v.Name) > 0 THEN CONVERT(CHAR(60), LTRIM(SUBSTRING(v.Name, 1, CHARINDEX('~', v.Name) - 1)) + ', ' + 
	LTRIM(RTRIM(SUBSTRING(v.Name, CHARINDEX('~', v.Name) + 1, 60)))) ELSE v.Name END AS [Vendor Name],
rd.Project AS [Project], rd.Task AS [Task], rd.Acct AS [Expense Account], rd.Sub AS [Expense Subaccount],rd.CuryUnitCost AS [Currency Unit Cost],  
rd.CuryEstimatedExtcost AS [Currency Estimated Extended Cost],r.IrTotal AS [Item Request Header Total], rd.MaterialType AS [Material Type], 
rd.AppvLevObt AS [Approval Level Obtained], rd.AppvLevReq AS [Approval Level Required], rd.CatalogInfo AS [Catalog Information], rd.CnvFact AS [Conversion Factor], 
rd.CpnyID AS [Company ID], convert(date,rd.crtd_datetime) AS [Create Date], rd.crtd_prog AS [Create Program], rd.crtd_user AS [Create User], 
rd.CuryEstimateCost AS [Currency Estimated Cost], rd.CuryID AS [Currency ID], rd.CuryMultDiv AS [Currency Multiply or Divide], rd.CuryRate AS [Currency Rate], 
rd.CuryRateType AS [Currency Rate Type], rd.CuryTaxAmt00 AS [Currency Tax Amount 1], rd.CuryTaxAmt01 AS [Currency Tax Amount 2], 
rd.CuryTaxAmt02 AS [Currency Tax Amount 3], rd.CuryTaxAmt03 AS [Currency Tax Amount 4], rd.CuryTxblAmt00 AS [Currency Taxable Amount 1], 
rd.CuryTxblAmt01 AS [Currency Taxable Amount 2], rd.CuryTxblAmt02 AS [Currency Taxable Amount 3], rd.CuryTxblAmt03 AS [Currency Taxable Amount 4],
rd.EstimateCost AS [Estimated Cost], rd.EstimatedExtcost AS [Estimated Extended Cost],rd.LineNbr AS [Line Number], 
convert(date,rd.lupd_datetime) AS [Last Update Date], rd.lupd_prog AS [Last Update Program], rd.lupd_user AS [Last Update User], rd.NoteId AS [Note ID], 
rd.PolicyLevObt AS [Policy Level Obtained], rd.PolicyLevReq AS [Policy Level Required], rd.PrefVendor AS [Preferred Vendor ID], 
convert(date,rd.ReqDate) AS [Required Date], rd.ReqNbr AS [Requisition Number], rd.SiteID AS [Site ID],  rd.User1 AS [User 1], rd.User2 AS [User 2], 
rd.User3 AS [User 3], rd.User4 AS [User 4], rd.User5 AS [User 5], rd.User6 AS [User 6], convert(date,rd.User7) AS [User 7], convert(date,rd.User8) AS [User 8], 
rd.VendItemID AS [Vendor Item ID]

From	RQItemReqDet rd with (nolock)
			left outer Join RQDept d with (nolock) on rd.Dept = d.DeptID
			Left outer Join RQItemReqHdr r with (nolock) on rd.ItemReqNbr = r.ItemReqNbr
			left outer join vendor v with (nolock) on r.VendID = v.VendId

 

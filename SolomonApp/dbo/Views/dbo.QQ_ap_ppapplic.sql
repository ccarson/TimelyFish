
CREATE VIEW [QQ_ap_ppapplic]
AS
	Select Distinct pp.vendid AS [Vendor ID], v.Name [Vendor Name], pp.PrePay_RefNbr as [Pre-Payment Number], 
		pp.AdjdRefNbr as [Adjusted Reference Number], pp.AdjdDocType as [Adjusted Document Type], 
		pp.BatNbr as [Batch Number], adj.AdjAmt as [Applied Amount], d.CpnyID as [Company ID]
		From AP_PPApplic pp 
		left join Vendor v on pp.VendId = v.VendId
		left join APAdjust adj on pp.AdjdRefNbr = adj.AdjdRefNbr and pp.PrePay_RefNbr = adj.PrePay_RefNbr
		left join APDoc d on pp.PrePay_RefNbr = d.RefNbr
		Where adj.AdjdRefNbr <> '' and d.DocType = 'PP'


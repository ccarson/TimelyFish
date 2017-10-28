
CREATE VIEW [QQ_sosched]
AS
SELECT	S.CpnyID AS [Company ID], H.CustID, CASE WHEN CHARINDEX('~' , C.Name) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(C.Name, 1 , 
		CHARINDEX('~' , C.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(C.Name, CHARINDEX('~' , C.Name) + 1 , 60)))) ELSE C.Name END AS [Customer Name], 
		S.OrdNbr AS [Order Number], S.LineRef AS [Line Reference Number], S.SchedRef AS [Schedule Reference Number], L.InvtID AS [Inventory ID], 
		S.SiteID, S.QtyOrd AS [Quantity Ordered], S.QtyShip AS [Quantity Shipped], S.QtyOpenShip AS [Quantity on Open Shippers], 
		S.QtyCloseShip AS [Quantity on Closed Shippers], S.QtyToInvc AS [Quantity to Invoice], CONVERT(DATE,S.PromDate) AS [Promised Date], 
		CONVERT(DATE,S.ReqDate) AS [Requested Date], S.ShipViaID, H.Status as [Order Status], L.Status AS [Line Status], S.Status AS [Schedule Status], 
		CONVERT(DATE,S.CancelDate) AS [CancelDate], S.MarkFor, M.MarkForType, M.CustID AS [Mark For Customer ID], M.MarkForID AS [Mark For Customer Address ID], 
		M.VendID AS [Mark For Vendor ID], M.S4Future11 AS [Mark For Vendor Address ID], M.SiteID AS [Mark For Site ID], 
		M.AddrID AS [Mark For Other ID], M.ShipViaID AS [Mark For Ship Via ID], S.AutoPO AS [Automatic PO Creation], 
		S.AutoPOVendID AS [Automatic PO Vendor ID], S.S4Future04 AS [Blanket Order Quantity], 
		S.S4Future02 AS [Blanket Order Schedule Reference Number], CONVERT(DATE,S.Crtd_DateTime) AS [Create Date], S.Crtd_Prog AS [Create Program],
		S.Crtd_User AS [Create User], S.CuryTaxAmt00 AS [Currency Tax Amount 01], S.CuryTaxAmt01 AS [Currency Tax Amount 02], 
		S.CuryTaxAmt02 AS [Currency Tax Amount 03], S.CuryTaxAmt03 AS [Currency Tax Amount 04], 
		S.CuryTxblAmt00 AS [Currency Taxable Amount 01], S.CuryTxblAmt01 AS [Currency Taxable Amount 02], 
		S.CuryTxblAmt02 AS [Currency Taxable Amount 03], S.CuryTxblAmt03 AS [Currency Taxable Amount 04], S.DropShip, 
		S.FrtCollect AS [Freight Collect], S.Hold AS [Manual Hold], S.LotSerialEntered AS [Lot/Serial Number Entered], 
		S.LotSerialReq AS [Lot/Serial Number Required], CONVERT(DATE,S.LUpd_DateTime) AS [Last Update Date], S.LUpd_Prog AS [Last Update Program],
		S.LUpd_User AS [Last Update User], S.NoteID, S.PremFrt AS [Premium Freight], CONVERT(DATE,S.PriorityDate) AS [Priority Date], 
		S.PrioritySeq AS [Priority Sequence], CONVERT(TIME,S.PriorityTime) AS [Priority Time], CONVERT(DATE,S.ReqPickDate) AS [Requested Pick Date], 
		S.S4Future05 AS [Normalized Quantity Ordered], S.S4Future06 AS [Normalized Quantity Shipped], 
		S.ShipAddrID AS [Other Shipping Address ID], S.ShipCustID AS [Shipping Customer ID], CONVERT(DATE,S.ShipDate) AS [ShipDate], 
		S.S4Future01 AS [Ship Name], S.S4Future09 AS [Ship Now], S.ShipSiteID AS [From Site ID (transfer order)], S.ShiptoID, 
		S.ShiptoType, S.ShipVendID AS [Vendor ID], S.S4Future12 AS [Shipping Zip], S.TaxAmt00 AS [Tax Amount 01], 
		S.TaxAmt01 AS [Tax Amount 02], S.TaxAmt02 AS [Tax Amount 03], S.TaxAmt03 AS [Tax Amount 04], 
		S.TaxCat AS [Tax Category], S.TaxID00 AS [Tax ID 01], S.TaxID01 AS [Tax ID 02], S.TaxID02 AS [Tax ID 03], 
		S.TaxID03 AS [Tax ID 04], S.TaxIDDflt AS [Tax ID Default], S.TransitTime, S.TxblAmt00 AS [Taxable Amount 01], 
		S.TxblAmt01 AS [Taxable Amount 02], S.TxblAmt02 AS [Taxable Amount 03], S.TxblAmt03 AS [Taxable Amount 04], 
		S.User1, S.User2, S.User3, S.User4, S.User5, S.User6, CONVERT(DATE,S.User7) AS [User7], CONVERT(DATE,S.User8) AS [User8], 
		CONVERT(DATE,S.User9) AS [User9], CONVERT(DATE,S.User10) AS [User10], S.S4Future11 AS [Vendor Address ID]
FROM	SOSched S with (nolock)
			INNER JOIN SOLine L with (nolock) ON S.CpnyID = L.CpnyID AND S.OrdNbr = L.OrdNbr AND S.LineRef = L.LineRef 
			INNER JOIN SOHeader H with (nolock) ON S.CpnyID = H.CpnyID AND S.OrdNbr = H.OrdNbr 
			LEFT OUTER JOIN SOSchedMark M with (nolock) ON S.CpnyID = M.CpnyID AND S.LineRef = M.LineRef AND S.OrdNbr = M.OrdNbr AND S.SchedRef = M.SchedRef
			INNER JOIN Customer C with (nolock) ON H.CustID = C.CustId


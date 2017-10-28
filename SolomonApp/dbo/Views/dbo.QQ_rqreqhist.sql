
CREATE VIEW [QQ_rqreqhist]
AS
SELECT     HI.ReqNbr AS [Requisition Number], CONVERT(DATE,HI.TranDate) AS [Transaction Date], CONVERT(TIME,HI.TranTime) AS [Transaction Time], 
		CONVERT(DATE,H.PODate) AS [Purchase Order Date], HI.Status, D.InvtID AS [Inventory ID], HI.Descr AS Description, CASE WHEN CHARINDEX('~' , V.Name) > 0 
		THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(V.Name, 1 , CHARINDEX('~' , V.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(V.Name, CHARINDEX('~' , V.Name) + 1 , 60)))) 
		ELSE V.Name END AS Vendor, CASE WHEN CHARINDEX('~' , H.RequstnrName) > 0 THEN CONVERT (CHAR(60) , LTRIM(SUBSTRING(H.RequstnrName, 1 , 
		CHARINDEX('~' , H.RequstnrName) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(H.RequstnrName, CHARINDEX('~' , H.RequstnrName) + 1 , 60)))) ELSE H.RequstnrName 
		END AS [Requisitioner], HI.UniqueID AS [Line Number], D.Qty AS Quantity, D.UnitCost, D.ExtCost AS [Extended Cost], HI.ApprPath AS [Approval Path], 
		HI.Authority, HI.Comment, CONVERT(DATE,HI.crtd_datetime) AS [Create Date], HI.crtd_prog AS [Create Program], HI.crtd_user AS [Create User], 
		CONVERT(DATE,HI.lupd_datetime) AS [Last Update Date], HI.lupd_prog AS [Last Update Program], HI.lupd_user AS [Last Update User], HI.NoteID, HI.ReqCntr 
		AS [Requisition Counter], HI.RowNbr, HI.S4Future1, HI.S4Future2, HI.S4Future3, HI.S4Future4, HI.S4Future5, HI.S4Future6, CONVERT(DATE,HI.S4Future7) 
		AS [S4Future7], CONVERT(DATE,HI.S4Future8) AS [S4Future8], HI.S4Future9, HI.S4Future10, HI.S4Future11, HI.S4Future12, HI.TranAmt AS [Transaction Amount], 
		HI.User1, HI.User2, HI.User3, HI.User4, HI.User5, HI.User6, CONVERT(DATE,HI.User7) AS [User7], CONVERT(DATE,HI.User8) AS [User8], HI.UserID, HI.zzComment

FROM	RQReqDet D with (nolock) 
			INNER JOIN RQReqHdr H with (nolock) ON D.CpnyID = H.CpnyID AND D.ReqNbr = H.ReqNbr 
			INNER JOIN RQReqHist HI with (nolock) ON D.LineKey = HI.UniqueID 
			LEFT OUTER JOIN Vendor V with (nolock) ON H.VendID = V.VendId


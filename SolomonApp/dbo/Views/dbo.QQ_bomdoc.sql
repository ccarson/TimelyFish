
CREATE VIEW [QQ_bomdoc]
AS
SELECT	D.CpnyID AS [Company ID], D.BatNbr AS [Batch Number], D.PerPost AS [Period to Post], D.RefNbr AS [Reference Number], D.KitID AS [Kit ID], 
		TI.Descr AS [Kit Description], D.AssyQty AS [Kit Qty], D.SiteID AS [Site ID], D.WhseLoc AS [Whse Bin Loc], D.Rlsed AS Released, 
		D.Status AS [BOM Status], T.LineRef AS [Line Reference Number], T.CmpnentID AS [Component ID], DI.Descr AS [Component Description], 
		T.CmpnentQty AS [Component Qty], T.SiteID AS [Component Site ID], T.WhseLoc AS [Component Whse Bin Loc], T.Status AS [Line Status], 
		T.UnitPrice AS [Unit Price], T.TranAmt AS [Transaction Amount], D.LotSerNbr AS [Kit Lot/Serial Nbr], T.LotSerNbr AS [Component Lot/Serial Nbr], 
		D.S4Future01 AS [Kit S4Future01], D.S4Future02 AS [Kit S4Future02], D.S4Future03 AS [Kit S4Future03], D.S4Future04 AS [Kit S4Future04], 
        D.S4Future05 AS [Kit S4Future05], D.S4Future06 AS [Kit S4Future06], CONVERT(DATE,D.S4Future07) AS [Kit S4Future07], 
        CONVERT(DATE,D.S4Future08) AS [Kit S4Future08], D.S4Future09 AS [Kit S4Future09], D.S4Future10 AS [Kit S4Future10], 
		D.S4Future11 AS [Kit S4Future11], D.S4Future12 AS [Kit S4Future12], D.User1 AS [Kit User1], D.User2 AS [Kit User2], D.User3 AS [Kit User3], 
		D.User4 AS [Kit User4], D.User5 AS [Kit User5], D.User6 AS [Kit User6], CONVERT(DATE,D.User7) AS [Kit User7], CONVERT(DATE,D.User8) AS [Kit User8], 
		T.S4Future01 AS [Component S4Future01], T.S4Future02 AS [Component S4Future02], T.S4Future03 AS [Component S4Future03], 
		T.S4Future04 AS [Component S4Future04], T.S4Future05 AS [Component S4Future05], T.S4Future06 AS [Component S4Future06], 
		CONVERT(DATE,T.S4Future07) AS [Component S4Future07], CONVERT(DATE,T.S4Future08) AS [Component S4Future08], T.S4Future09 AS [Component S4Future09], 
		T.S4Future10 AS [Component S4Future10], T.S4Future11 AS [Component S4Future11], T.S4Future12 AS [Component S4Future12], T.User1 AS [Component User1], 
		T.User2 AS [Component User2], T.User3 AS [Component User3], T.User4 AS [Component User4], T.User5 AS [Component User5], T.User6 AS [Component User6], 
		CONVERT(DATE,T.User7) AS [Component User7], CONVERT(DATE,T.User8) AS [Component User8]
FROM	BOMDoc D with (nolock)
			INNER JOIN Inventory DI with (nolock) ON D.KitID = DI.InvtID
			INNER JOIN BOMTran T with (nolock) ON D.BatNbr = T.BatNbr and D.RefNbr = T.RefNbr
			INNER JOIN Inventory AS TI with (nolock) ON T.CmpnentID = TI.InvtID


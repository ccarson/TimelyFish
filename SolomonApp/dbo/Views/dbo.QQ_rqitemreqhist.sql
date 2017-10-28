
CREATE VIEW [QQ_rqitemreqhist]
AS
SELECT     H.ItemReqNbr AS [Item Request Number], CONVERT(DATE,H.TranDate) AS [Transaction Date], H.Status, 
                      RQItemReqHdr.Descr AS [Item Request Description], H.UserID AS Requester, RQItemReqHdr.Dept AS Department, 
                      H.TranAmt AS [Transaction Amount], H.ApprPath AS [Approval Path], H.Authority, H.Comment, 
                      CONVERT(DATE,H.crtd_datetime) AS [Create Date], H.crtd_prog AS [Create Program], H.crtd_user AS [Create User], 
                      H.Descr, CONVERT(DATE,H.lupd_datetime) AS [Last Update Date], H.lupd_prog AS [Last Update Program], 
                      H.lupd_user AS [Last Update User], H.NoteID, H.RowNbr AS [Row Number], H.S4Future1, H.S4Future2, H.S4Future3, 
                      H.S4Future4, H.S4Future5, H.S4Future6, CONVERT(DATE,H.S4Future7) AS [S4Future07], CONVERT(DATE,H.S4Future8) AS [S4Future08], 
                      H.S4Future9, H.S4Future10, H.S4Future11, H.S4Future12, H.TranTime AS [Transaction Time], H.UniqueID, H.User1, H.User2, 
                      H.User3, H.User4, H.User5, H.User6, CONVERT(DATE,H.User7) AS [User7], CONVERT(DATE,H.User8) AS [User8]
FROM         RQItemReqHist H with (nolock)
	INNER JOIN RQItemReqHdr with (nolock) ON H.ItemReqNbr = RQItemReqHdr.ItemReqNbr


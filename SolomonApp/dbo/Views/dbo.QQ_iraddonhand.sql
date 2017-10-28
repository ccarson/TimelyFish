
CREATE VIEW [QQ_iraddonhand]
AS
SELECT	A.InvtID AS [Inventory ID], I.Descr AS [Inventory Description], A.SiteID, CONVERT(DATE,A.OnDate) AS [Date Needed], 
        A.QtyDesired AS [Additional Safety Stock Qty Needed], CONVERT(DATE,A.Crtd_Datetime) AS [Create Date], A.Crtd_Prog AS [Create Program], 
        A.Crtd_User AS [Create User], CONVERT(DATE,A.Lupd_Datetime) AS [Last Update Date], A.Lupd_Prog AS [Last Update Program], 
        A.Lupd_User AS [Last Update User], A.S4Future01, A.S4Future02, A.S4Future03, A.S4Future04, A.S4Future05, A.S4Future06, 
        CONVERT(DATE,A.S4Future07) AS [S4Future07], CONVERT(DATE,A.S4Future08) AS [S4Future08], A.S4Future09, A.S4Future10, A.S4Future11, 
        A.S4Future12, A.User1, A.User2, A.User3, A.User4, A.User5, A.User6, CONVERT(DATE,A.User7) AS [User7], CONVERT(DATE,A.User8) AS [User8], 
        CONVERT(DATE,A.User9) AS [User9], CONVERT(DATE,A.User10) AS [User10]
FROM	IRAddOnHand A with (nolock) 
			INNER JOIN Inventory I with (nolock) ON A.InvtID = I.InvtID


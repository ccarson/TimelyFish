
CREATE VIEW [QQ_ap_balances]
AS
SELECT 
     a.VendID AS [Vendor ID], CASE WHEN CHARINDEX('~', v.Name) > 0 THEN CONVERT(CHAR(60), 
	 LTRIM(SUBSTRING(v.Name, 1, CHARINDEX('~',v.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(v.Name, CHARINDEX('~',v.Name) + 1, 60)))) ELSE v.Name END AS [Vendor Name], 
     a.CpnyID AS [Company ID], a.PerNbr AS [Period Number], a.CurrBal AS [Current Balance], a.FutureBal AS [Future Balance], 
     convert(date,a.LastChkDate) AS [Last Check Date], convert(date,a.LastVODate) AS [Last Voucher Date], a.CuryID AS [Currency ID], 
     a.CYBox00 AS [Current Year 1099 Box 1], a.CYBox01 AS [Current Year 1099 Box 2], a.CYBox02 AS [Current Year 1099 Box 3], a.CYBox03 AS [Current Year 1099 Box 4], 
     a.CYBox04 AS [Current Year 1099 Box 5], a.CYBox05 AS [Current Year 1099 Box 6], a.CYBox06 AS [Current Year 1099 Box 7], a.CYBox07 AS [Current Year 1099 Box 8], 
     a.CYBox11 AS [Current Year 1099 Box 15a], a.CYBox12 AS [Current Year 1099 Box 15b],
     a.CYBox13 AS [Current Year 1099 Box 13], a.CYBox14 AS [Current Year 1099 Box 14],   
     a.NYBox00 AS [Next Year 1099 Box 1], a.NYBox01 AS [Next Year 1099 Box 2], a.NYBox02 AS [Next Year 1099 Box 3], a.NYBox03 AS [Next Year 1099 Box 4], 
     a.NYBox04 AS [Next Year 1099 Box 5], a.NYBox05 AS [Next Year 1099 Box 6], a.NYBox06 AS [Next Year 1099 Box 7], a.NYBox07 AS [Next Year 1099 Box 8],
     a.NYBox11 AS [Next Year 1099 Box 15a], a.NYBox12 AS [Next Year 1099 Box 15b], a.NYBox13 AS [Next Year 1099 Box 13], a.NYBox14 AS [Next Year 1099 Box 14],  
     convert(date,a.Crtd_DateTime) AS [Create Date], a.Crtd_Prog AS [Create Program], a.Crtd_User AS [Create User], 
     convert(date,a.LUpd_DateTime) AS [Last Update Date], a.LUpd_Prog [Last Update Program], a.LUpd_User AS [Last Update User], a.NoteID,
     a.User1, a.User2,a.User3, a.User4, a.User5, a.User6, convert(date,a.User7) AS [User7], convert(date,a.User8) AS [User8]
FROM    Ap_balances a with (nolock)
        INNER JOIN Vendor v with (nolock) ON a.VendID = v.VendId
        

-- ==========================================================================================================
-- Date			Author	Change Description
-- ----------   ------- -------------------------------------------------------------------------------------
-- 1/10/2014	BMD		Added "ClassId" from customer table to view select list
-- 
--
-- ==========================================================================================================

CREATE VIEW [dbo].[QQ_ar_balances]
AS
SELECT	    
     b.CustID AS [Customer ID],  CASE WHEN CHARINDEX('~', C.Name) > 0 THEN CONVERT(CHAR(60), 
	 LTRIM(SUBSTRING(C.Name, 1, CHARINDEX('~',C. Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX('~',C.Name) + 1, 60)))) ELSE C.Name END AS [Customer Name], 
     b.CpnyID AS [Company ID], b.CurrBal AS [Current Balance],b.FutureBal AS [Future Balance], b.AgeBal00 AS [Age Balance 1], b.AgeBal01 AS [Age Balance 2], 
     b.AgeBal02 AS [Age Balance 3], b.AgeBal03 AS [Age Balance 4], b.AgeBal04 AS [Age Balance 5], b.AvgDayToPay AS [Average Days to Pay], b.CrLmt AS [Credit Limit], 
     convert(date,b.Crtd_DateTime) AS [Create Date], b.Crtd_Prog AS [Create Program], b.Crtd_User AS [Create User], b.CuryID AS [Currency ID],  
     convert(date,b.LastActDate) AS [Last Activity Date], convert(date,b.LastAgeDate) AS [Last Aging Date], convert(date,b.LastFinChrgDate) AS 
     [Last Finance Charge Date], convert(date,b.LastInvcDate) AS [Last Invoice Date], b.LastStmtBal00 AS [Last Statement Balance 1], b.LastStmtBal01 AS 
     [Last Statement Balance 2], b.LastStmtBal02 AS [Last Statement Balance 3], b.LastStmtBal03 AS [Last Statement Balance 4], b.LastStmtBal04 AS 
     [Last Statement Balance 5], b.LastStmtBegBal AS [Last Statement Beginning Balance], convert(date,b.LastStmtDate) AS [Last Statement Date], 
     convert(date,b.LUpd_DateTime) AS [Last Update Date], b.LUpd_Prog AS [Last Update Program], b.LUpd_User AS [Last Update User], b.NbrInvcPaid AS 
     [Number Invoices Paid], b.NoteId, b.PaidInvcDays AS [Paid Invoice Days], b.PerNbr AS [Period Number], b.TotOpenOrd AS [Total Open Orders], b.TotPrePay AS 
     [Total Pre-Payments], b.TotShipped AS [Total Shipped], b.User1, b.User2, b.User3, b.User4, b.User5, b.User6, convert(date,b.User7) AS [User7], 
     convert(date,b.User8) AS [User8], C.ClassId as [Class ID]
FROM	ar_balances b with (nolock)
        INNER JOIN Customer C with (nolock) ON b.CustID = c.CustId



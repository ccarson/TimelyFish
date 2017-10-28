
CREATE VIEW [QQ_accthist]
AS
select 
accthist.Acct AS [Account], account.Descr as [Account Description], Accthist.sub AS [Subaccount], SubAcct.Descr AS [Subaccount Description],
accthist.LedgerID AS [Ledger ID],Ledger.Descr AS [Ledger Description],accthist.FiscYr AS [Fiscal Year],accthist.BalanceType [Balance Type],
accthist.CuryId AS [Currency ID], accthist.BegBal AS [Beginning Balance],
Ledger.BalRequired AS [Balance Required], Ledger.BaseCuryID AS [Base Currency ID],
 Ledger.UnitofMeas as [UOM],
accthist.AnnBdgt AS [Annual Budget],accthist.AnnMemo1 AS [Annual Memo 1], 
CONVERT(DATE,accthist.BdgtRvsnDate) AS [Budget Revision Date], accthist.CpnyID AS [Company ID], 
convert(date,accthist.Crtd_DateTime) AS [Create Date], accthist.Crtd_Prog AS [Create Program], 
accthist.Crtd_User AS [Create User], accthist.LastClosePerNbr AS [Last Closed Business Period], 
convert(date,accthist.LUpd_DateTime) AS [Last Update Date], accthist.LUpd_Prog AS [Last Update Program], 
accthist.LUpd_User AS [Last Update User], accthist.NoteID AS [Note ID], 
accthist.PtdAlloc00 AS [PTB Allocation Amount 01], 
accthist.PtdAlloc01 AS [PTB Allocation Amount 02], accthist.PtdAlloc02 AS [PTB Allocation Amount 03], 
accthist.PtdAlloc03 AS [PTB Allocation Amount 04], accthist.PtdAlloc04 AS [PTB Allocation Amount 05], 
accthist.PtdAlloc05 AS [PTB Allocation Amount 06], accthist.PtdAlloc06 AS [PTB Allocation Amount 07], 
accthist.PtdAlloc07 AS [PTB Allocation Amount 08], accthist.PtdAlloc08 AS [PTB Allocation Amount 09], 
accthist.PtdAlloc09 AS [PTB Allocation Amount 10], accthist.PtdAlloc10 AS [PTB Allocation Amount 11], 
accthist.PtdAlloc11 AS [PTB Allocation Amount 12], accthist.PtdAlloc12 AS [PTB Allocation Amount 13], 
accthist.PtdBal00 AS [PTD Balance 01], accthist.PtdBal01 AS [PTD Balance 02], 
accthist.PtdBal02 AS [PTD Balance 03], accthist.PtdBal03 AS [PTD Balance 04], 
accthist.PtdBal04 AS [PTD Balance 05], accthist.PtdBal05 AS [PTD Balance 06], 
accthist.PtdBal06 AS [PTD Balance 07], accthist.PtdBal07 AS [PTD Balance 08], 
accthist.PtdBal08 AS [PTD Balance 09], accthist.PtdBal09 AS [PTD Balance 10], 
accthist.PtdBal10 AS [PTD Balance 11], accthist.PtdBal11 AS [PTD Balance 12], 
accthist.PtdBal12 AS [PTD Balance 13], accthist.PtdCon00 AS [PTD Consolidated Balance 01], 
accthist.PtdCon01 AS [PTD Consolidated Balance 02], accthist.PtdCon02 AS [PTD Consolidated Balance 03], 
accthist.PtdCon03 AS [PTD Consolidated Balance 04], accthist.PtdCon04 AS [PTD Consolidated Balance 05], 
accthist.PtdCon05 AS [PTD Consolidated Balance 06], accthist.PtdCon06 AS [PTD Consolidated Balance 07], 
accthist.PtdCon07 AS [PTD Consolidated Balance 08], accthist.PtdCon08 AS [PTD Consolidated Balance 09], 
accthist.PtdCon09 AS [PTD Consolidated Balance 10], accthist.PtdCon10 AS [PTD Consolidated Balance 11], 
accthist.PtdCon11 AS [PTD Consolidated Balance 12], accthist.PtdCon12 AS [PTD Consolidated Balance 13], 
accthist.User1 AS [User1], accthist.User2 AS [User2], accthist.User3 AS [User3], 
accthist.User4 AS [User4], accthist.User5 AS [User5], accthist.User6 AS [User6], 
convert(date,accthist.User7) AS [User7], convert(date,accthist.User8) AS [User8], accthist.YtdBal00 AS [Year-to-Date Balance 01], 
accthist.YtdBal01 AS [Year-to-Date Balance 02], accthist.YtdBal02 AS [Year-to-Date Balance 03], 
accthist.YtdBal03 AS [Year-to-Date Balance 04], accthist.YtdBal04 AS [Year-to-Date Balance 05], 
accthist.YtdBal05 AS [Year-to-Date Balance 06], accthist.YtdBal06 AS [Year-to-Date Balance 07], 
accthist.YtdBal07 AS [Year-to-Date Balance 08], accthist.YtdBal08 AS [Year-to-Date Balance 09], 
accthist.YtdBal09 AS [Year-to-Date Balance 10], accthist.YtdBal10 AS [Year-to-Date Balance 11], 
accthist.YtdBal11 AS [Year-to-Date Balance 12], accthist.YtdBal12 AS [Year-to-Date Balance 13]
from accthist with (nolock)
Left Outer Join Account with (nolock)
on accthist.acct = account.acct
Left Outer Join Ledger with (nolock)
on accthist.LedgerID = Ledger.LedgerID
Left Outer Join subacct with (nolock)
on AcctHist.Sub = SubAcct.sub

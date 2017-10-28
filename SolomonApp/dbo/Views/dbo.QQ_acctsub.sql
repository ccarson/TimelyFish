
CREATE VIEW [QQ_acctsub]
AS
select 
acctsub.Acct AS [Account], acct.Descr AS [Account Description], 
acctsub.Sub AS [Subaccount], subacct.Descr AS [Subaccount Description], acctsub.Descr AS [Account/Sub Description],
acctsub.Active AS [Combination Status], acctsub.CpnyID AS [Company ID],
convert(date,acctsub.Crtd_DateTime) AS [Create Date], acctsub.Crtd_Prog AS [Create Program], acctsub.Crtd_User AS [Create User], 
convert(date,acctsub.LUpd_DateTime) AS [Last Update Date], acctsub.LUpd_Prog AS [Last Update Program], 
acctsub.LUpd_User AS [Last Update User], acctsub.NoteID AS [Noted ID], acctsub.User1 AS [User1], 
acctsub.User2 AS [User2], acctsub.User3 AS [User3], acctsub.User4 AS [User4], acctsub.User5 AS [User5], acctsub.User6 AS [User6], 
CONVERT(DATE,acctsub.User7) AS [User7], CONVERT(DATE,acctsub.User8) AS [User8], acct.Active AS [Account Active], acct.Consolacct AS [Consolidation Account], 
subacct.Active AS [Subaccount Active], subacct.ConsolSub AS [Consolidation Subaccount]
from vs_AcctSub acctsub with (nolock)
left outer join  Account acct with (nolock)
on acctsub.Acct = acct.Acct
left outer join SubAcct subacct with (nolock)
on acctsub.sub = subacct.Sub


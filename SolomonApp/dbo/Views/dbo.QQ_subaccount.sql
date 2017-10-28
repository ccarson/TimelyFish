
CREATE VIEW [QQ_subaccount]
AS
select 
subacct.Sub AS [Subaccount], subacct.Descr AS [Description], subacct.Active AS [Subaccount Status], 
subacct.ConsolSub AS [Consolidation Subaccount], convert(date,subacct.Crtd_DateTime) AS [Create Date], 
subacct.Crtd_Prog AS [Create Program], subacct.Crtd_User AS [Create User], 
convert(date,subacct.LUpd_DateTime) AS [Last Update Date], subacct.LUpd_Prog AS [Last Update Program], 
subacct.LUpd_User AS [Last Update User], subacct.NoteID AS [NoteID], subacct.User1 AS [User1], 
subacct.User2 AS [User2], subacct.User3 AS [User3], subacct.User4 AS [User4], subacct.User5 AS [User5], 
subacct.User6 AS [User6], convert(date,subacct.User7) AS [User7], convert(date,subacct.User8) AS [User8]
from subacct with (nolock)

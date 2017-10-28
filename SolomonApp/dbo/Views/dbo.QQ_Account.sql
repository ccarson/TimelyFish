 
CREATE VIEW [QQ_Account]
AS
SELECT  Acct as [Account Number], AcctType as [Account Type], Active as [Active], ClassID as [Class ID], ConsolAcct as [Consolidation Account Number],
Descr as [Description], Acct_Cat as [Project Account Category], CuryId as [Currency ID], RatioGrp as [Ratio Group], UnitofMeas as [UOM],
Acct_Cat_SW as [Account Category is Specified], convert(date,Crtd_DateTime) as [Create Date], Crtd_Prog as [Create Program], Crtd_User as [Create User], 
Employ_Sw as [Employee Must Be Specified], convert(date,LUpd_DateTime) as [Last Update Date], LUpd_Prog as [Last Update Program], 
LUpd_User as [Last Update User], NoteID as [NoteID], Units_SW as [Specify Units], User1 as [User1], User2 as [User2], User3 as [User3], User4 as [User4], 
User5 as [User5], User6 as [User6], convert(date,User7) as [User7], convert(date,User8) as [User8], ValidateID as [Validate ID]

from Account with (nolock)


create view vs_AcctSubStab
as
select 
Acct as Acct2,
Active,CpnyID,Crtd_DateTime,Crtd_Prog,Crtd_User,Descr as Descr2, LUpd_DateTime,LUpd_Prog,LUpd_User,
NoteID,S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,S4Future06,S4Future07,S4Future08,
S4Future09,S4Future10,S4Future11,S4Future12,Sub,User1,User2,User3,User4,User5,User6,User7,
User8,tstamp             
from vs_acctsub

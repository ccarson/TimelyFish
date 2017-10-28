 CREATE PROCEDURE ADG_Create_AR_RefNbr
	@RefNbr		Varchar(10)
AS
INSERT REFNBR (Crtd_DateTime,Crtd_Prog,Crtd_User,DocType,LUpd_DateTime,LUpd_Prog,LUpd_User,RefNbr,
	S4Future01,S4Future02,S4Future03,S4Future04,S4Future05,S4Future06,S4Future07,S4Future08,
	S4Future09,S4Future10,S4Future11,S4Future12,User1,User2,User3,User4,User5,User6,User7,User8,tstamp)
SELECT	'','','','','','','',@RefNbr,
	'','',0.0,0.0,0.0,0.0,'','',
	0,0,'','','','',0.0,0.0,'','','','',null



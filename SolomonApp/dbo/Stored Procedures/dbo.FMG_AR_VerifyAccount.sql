 CREATE PROCEDURE FMG_AR_VerifyAccount @Parm1 VARCHAR (10) AS

SELECT * FROM account WHERE Acct = @Parm1



 

/***** Last Modified by Jerry Johnson on 9/9/98 at 10:12pm *****/

--APPTABLE
--USETHISSYNTAX

CREATE VIEW vp_ShareAcctPostType AS

SELECT a.Acct, APPostType = CASE
	WHEN (SELECT GLPostOpt FROM APSetup (NOLOCK)) = "S" THEN "S"
	WHEN a.SummPost = "Y" THEN "S"
	ELSE "D"
	END, ARPostType = CASE
	WHEN (SELECT GLPostOpt FROM ARSetup (NOLOCK)) = "S" THEN "S"
	WHEN a.SummPost = "Y" THEN "S"
	ELSE "D"	END
FROM Account a

 

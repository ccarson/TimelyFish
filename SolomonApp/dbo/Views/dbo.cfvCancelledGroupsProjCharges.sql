
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 

/****** Object:  View dbo.cfvCancelledGroupsProjCharges    Script Date: 4/25/2005 4:30:36 PM ******/

CREATE   VIEW dbo.cfvCancelledGroupsProjCharges
AS

--*************************************************************
--	Purpose: Charges outstanding for cancelled pig groups
--	Author: Eric Lind
--	Date: 4/22/2005
--	Usage: Cancelled Groups Project Charges Report
--	
--*************************************************************

SELECT
	pj.project,
	pj.pjt_entity,
	pj.acct,
	pj.act_amount,
	pj.act_units

FROM PJPTDSUM pj
JOIN cftPigGroup pg ON pg.ProjectID = pj.project

WHERE pj.act_amount <> 0 AND pg.PGStatusID = 'X'

UNION

SELECT
	pj.project,
	pj.pjt_entity,
	pj.acct,
	pj.act_amount,
	pj.act_units

FROM PJPTDSUM pj
JOIN cftPigGroup pg ON pg.ProjectID = pj.project

WHERE pj.act_units <> 0

 




 
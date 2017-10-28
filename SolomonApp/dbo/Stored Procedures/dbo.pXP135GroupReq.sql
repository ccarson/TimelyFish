--*************************************************************
--	Purpose:Defines Source/Dest PigGroup existence requirement
--	Author: Charity Anderson
--	Date: 9/9/2004
--	Usage: PigTransportRecord app 
--	Parms:SubTypeID
--*************************************************************

CREATE PROC dbo.pXP135GroupReq
	@parm1 as varchar(2)
AS
Select Distinct a.acct,a.ca_id04 as EffectedSite
from cftPigAcctTran s
JOIN cftPigAcct t on s.acct=t.acct
JOIN pjacct a on a.acct=t.acct
JOIN cftPigAcctScrn sc on t.acct=sc.acct
where s.TranTypeID=@parm1 and sc.ScrnNbr='XP13500'

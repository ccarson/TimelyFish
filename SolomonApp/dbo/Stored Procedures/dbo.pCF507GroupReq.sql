--*************************************************************
--	Purpose:Defines Source/Dest PigGroup existence requirement
--	Author: Charity Anderson
--	Date: 9/9/2004
--	Usage: PigTransportRecord app 
--	Parms:SubTypeID
--*************************************************************

CREATE PROC dbo.pCF507GroupReq
	@parm1 as varchar(2)
AS
Select Distinct a.acct,a.ca_id04 as EffectedSite
from cftPGInvTSub s
JOIN cftPGInvTType t on s.TranTypeID=t.TranTypeID
JOIN pjacct a on a.acct=t.acct
JOIN cftPGTTypeScr sc on t.TranTypeID=sc.TranTypeID
where s.SubTypeID=@parm1 and sc.ScreenNbr='CF50700'

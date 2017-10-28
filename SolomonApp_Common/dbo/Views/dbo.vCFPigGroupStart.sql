
--*************************************************************
--	Purpose:Pig Group Start Date based on Transaction History
--		
--	Author: Charity Anderson
--	Date: 7/13/2005
--	Usage:  
--	Parms: None
--*************************************************************

CREATE VIEW dbo.vCFPigGroupStart

AS
Select PigGroupID ,min(TranDate) as TranDate
from cftPGInvTran WITH (NOLOCK)
where Reversal=0 
and InvEffect>0 
group by PigGroupID


--*************************************************************
--	Purpose:Pig Group End Date based on Transaction History
--		
--	Author: Charity Anderson
--	Date: 7/13/2005
--	Usage:  
--	Parms: None
--*************************************************************

CREATE VIEW dbo.vCFPigGroupEnd

AS
Select PigGroupID ,max(TranDate) as TranDate
from cftPGInvTran WITH (NOLOCK)
where Reversal=0 
and InvEffect<0 
group by PigGroupID

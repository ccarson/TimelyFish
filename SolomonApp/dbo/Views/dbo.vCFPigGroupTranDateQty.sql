--*************************************************************
--	Purpose: Group PigGroup Inv trans by Date and Group
--	Author: Charity Anderson
--	Date:  10/26/2004
--	Usage: View for finding group start date
--	Parms:
--*************************************************************
Create View vCFPigGroupTranDateQty
as
Select PigGroupID, TranDate, sum(qty*inveffect) as qty 
from cftPGInvTran 
Group by PigGroupID,TranDate

 


CREATE  View Temp7Day
AS
Select pg.SiteContactID, pg.PigGroupID, pg.Description, pg.PigProdphaseID, st.StartDate, Sum(tr.InvEffect * tr.Qty) As Qty7, gc.Capacity
From cftPigGroup pg 
LEFT JOIN cfv_GroupStart st ON pg.TaskID=st.TaskID
LEFT JOIN cftPGInvTran tr ON pg.PigGroupID=tr.PigGroupID
LEFT JOIN cfv_PigGroup_Capacity gc ON pg.PigGroupID=gc.PigGroupID
Where tr.acct In('PIG TRANSFER IN','PIG MOVE IN','PIG PURCHASE','PIG MOVE OUT') 
AND tr.Reversal<>'1' AND tr.trandate <= DATEADD(day, 7, st.StartDate)
AND pg.PigProdPhaseID IN ('NUR','FIN','WTF') AND pg.PigSystemID='00' AND pg.PGStatusID<>'X'
Group by pg.SiteContactID, pg.PigGroupID, pg.Description, pg.PigProdphaseID, st.StartDate, gc.Capacity



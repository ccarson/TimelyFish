
--*************************************************************
--	Purpose:Pig Group Transactions UNION query
--		
--	Author: Charity Anderson
--	Date: 7/15/2005
--	Usage: EssBase 
--	Parms: None
--*************************************************************

CREATE VIEW dbo.vCFPigGroupTranUNION
AS
Select PigGroupID,
TranTypeID+'_'+ TranSubTypeID + '_Qty'
as Account, abs(Qty) as Value
from cftPGInvTran pgt
WHERE Reversal=0 and pgt.Acct not in ('PIG SALE','PIG DEATH')

UNION ALL
Select pgt.PigGroupID,'PS_'+ psd.DetailTypeID + '_Qty',
psd.Qty as Value
from cftPGInvTran pgt
JOIN cftPigSale ps on pgt.SourceRefNbr=ps.RefNbr
JOIN cftPSDetail psd on ps.RefNbr=psd.RefNbr
WHERE Reversal=0 and pgt.Acct='PIG SALE'

UNION ALL
Select PigGroupID,
TranTypeID+'_'+ TranSubTypeID + '_Wgt'
as Account, 
abs(TotalWgt) as Value 
from cftPGInvTran pgt
WHERE Reversal=0 and pgt.Acct not in ('PIG SALE','PIG DEATH')

UNION ALL
Select PigGroupID,
'DEATHQty' as Account, 
Qty as Value 
from cftPGInvTran pgt
WHERE Reversal=0 and pgt.Acct='PIG DEATH'

UNION ALL
Select pgt.PigGroupID,'PS_'+ psd.DetailTypeID + '_Wgt',
psd.WgtLive as Value
from cftPGInvTran pgt
JOIN cftPigSale ps on pgt.SourceRefNbr=ps.RefNbr
JOIN cftPSDetail psd on ps.RefNbr=psd.RefNbr
WHERE Reversal=0 and pgt.Acct='PIG SALE'

UNION ALL
Select * from vCFPigGroupFeedUNION

UNION ALL
Select 
pg.PigGroupID, 'Unknown_FeedQty' as Account, 
Value=tr.Act_Units - (Select sum(Value) 
	from vCFPigGroupFeedUNION where PigGroupID=tr.pjt_entity)
FROM PJPTDSUM tr 
JOIN cftPigGroup pg on tr.pjt_entity=pg.TaskID
where tr.acct='PIG FEED ISSUE'

/*
Select 
pg.PigGroupID, rtrim(tr.InvtID) + '_FeedQty' as Account, (Qty) as Value
FROM APTran tr 
JOIN Batch b on tr.BatNbr=b.BatNbr and b.Module='AP'
JOIN cftPigGroup pg on tr.TaskID=pg.TaskID
JOIN Inventory i on tr.InvtID=i.InvtID and i.ClassID='Ration'
where b.Rlsed=1 and tr.InvtID>''  

UNION ALL
Select 
pg.PigGroupID, rtrim(InvtID) + '_FeedQty' as Account, (Qty*InvtMult*-1) as Value
FROM INTran tr 
JOIN Batch b on tr.BatNbr=b.BatNbr and b.Module='IN'
JOIN cftPigGroup pg on tr.TaskID=pg.TaskID
where b.Rlsed=1 and tr.TranType in ('II','RI','RC','IN') and tr.Acct='45500'


UNION ALL
Select 
pg.PigGroupID, 'Unknown_FeedQty' as Account, (units) as Value
FROM pjchargd tr 
JOIN cftPigGroup pg on tr.pjt_entity=pg.TaskID
where tr.acct='PIG FEED ISSUE'


UNION ALL 
Select
pg.PigGroupID, tr_Comment + '_FeedQty' as Account, (units) as Value
FROM PJTRAN tr
JOIN cftPigGroup pg on tr.pjt_entity=pg.TaskID
where tr.acct='PIG FEED ISSUE' and tr.units<>0
*/

UNION ALL
Select 
t.PigGroupID, 'LivePigDays' as Account,
(DateDiff(d,pg.TranDate,t.TranDate)*(Qty)*InvEffect*-1) as Value
from cftPGInvTran t
JOIN vCFPigGroupStart pg on t.PigGroupID=pg.PigGroupID
Where t.acct<>'PIG DEATH' and Reversal=0

UNION ALL
Select 
t.PigGroupID, 'DeadPigDays' as Account,(
DateDiff(d,pg.TranDate,t.TranDate)*(Qty)) as Value
from cftPGInvTran t
JOIN vCFPigGroupStart pg on t.PigGroupID=pg.PigGroupID
Where t.acct='PIG DEATH' and Reversal=0

UNION ALL
Select pg.PigGroupID,acct as Account, act_amount
from pjptdSUm psum JOIN cftPigGroup pg
on psum.pjt_entity=pg.TaskID



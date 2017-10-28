
--*************************************************************
--	Purpose:Pig Group Feed Transactions UNION query
--		
--	Author: Charity Anderson
--	Date: 2/21/2006
--	Usage: EssBase 
--	Parms: None
--*************************************************************

CREATE VIEW dbo.vCFPigGroupFeedUNION
AS
Select 
pg.PigGroupID, rtrim(i.User2) + '_FeedQty' as Account, (Qty) as Value
FROM APTran tr 
JOIN Batch b on tr.BatNbr=b.BatNbr and b.Module='AP'
JOIN cftPigGroup pg on tr.TaskID=pg.TaskID
JOIN Inventory i on tr.InvtID=i.InvtID and i.ClassID='Ration'
where b.Rlsed=1 and tr.InvtID>''  

UNION ALL
Select 
pg.PigGroupID, rtrim(i.User2) + '_FeedQty' as Account, (Qty*InvtMult*-1) as Value
FROM INTran tr 
JOIN Inventory i on tr.InvtID=i.InvtID
JOIN Batch b on tr.BatNbr=b.BatNbr and b.Module='IN'
JOIN cftPigGroup pg on tr.TaskID=pg.TaskID
where b.Rlsed=1 and tr.TranType in ('II','RI','RC','IN') and tr.Acct='45500'


UNION ALL
Select 
pg.PigGroupID, 'Unknown_FeedQty' as Account, (units) as Value
FROM pjchargd tr 
JOIN cftPigGroup pg on tr.pjt_entity=pg.TaskID
where tr.acct='PIG FEED ISSUE'





CREATE VIEW [dbo].[cfv_FeedOrder_051_052_20140917] 
(PigGroupId,pgdescription ,OrdNbr,DateSched,InvtIdOrd,qtyord
, Status, CommentId, Comment, MillId, OrdType
, Prior_ration_delivered,Last_051_delivery)
AS
select distinct
FO.PigGroupId
,PG.description 
, FO.OrdNbr
, FO.DateSched, FO.InvtIdOrd, FO.qtyord
, FO.Status, FO.CommentId, FO.Comment, FO.MillId, FO.OrdType
, last051.InvtIdDel Prior_ration_delivered,last051.lastdel as Last_051_delivery
from cftfeedorder FO (nolock)
inner join  
(select PigGroupId, ContactId		
--, MillId
, max(datedel) as lastdel 
FROM solomonapp.dbo.cftFeedOrder (nolock)
where DateSched >= GETDATE()-90
and Status in ('C','X') 
group by PigGroupId, ContactId		
--, MillId
) lastdelvrd      
    on lastdelvrd.PigGroupId = FO.PigGroupId
   and lastdelvrd.ContactId = FO.ContactId
--   and lastdelvrd.MillId = FO.MillId
inner join
(select PigGroupId, ContactId		
--, MillId
, Status, InvtIdDel
, max(datedel) as lastdel 
FROM solomonapp.dbo.cftFeedOrder (nolock)
where DateSched >= GETDATE()-90
and (InvtIdOrd like '051%' or InvtIdOrd like '043%') -- added the 043 check 5/18/2012 smr
and Status in ('C','X') 
group by PigGroupId, ContactId		
--, MillId
, Status, InvtIdDel
) last051     
    on last051.PigGroupId = FO.PigGroupId
   and last051.ContactId = FO.ContactId
--   and last051.MillId = FO.MillId
left join SolomonApp.dbo.cftPigGroup PG (nolock)
      on PG.PigGroupID = FO.PigGroupId
where fo.InvtIdOrd like '052%' 
and fo.Status not in ('C','X') 
and FO.OrdType not like 'R1' 
and lastdelvrd.lastdel = last051.lastdel
and FO.CommentId <> 'VAC'




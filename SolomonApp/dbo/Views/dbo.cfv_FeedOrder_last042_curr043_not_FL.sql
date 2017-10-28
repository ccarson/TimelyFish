






CREATE VIEW [dbo].[cfv_FeedOrder_last042_curr043_not_FL] 
(PigGroupId,pgdescription ,OrdNbr,BinNbr,DateSched,InvtIdOrd,qtyord
, binDescription, Status, CommentId, Comment, MillId, OrdType
, Prior_ration_delivered,Last_043_delivery, pigflowid)
AS
select 
FO.PigGroupId
,PG.description 
, FO.OrdNbr, FO.BinNbr, FO.DateSched, FO.InvtIdOrd, FO.qtyord
, bt.Description
, FO.Status, FO.CommentId, FO.Comment, FO.MillId, FO.OrdType
, last042.InvtIdDel Prior_ration_delivered,last042.lastdel as Last_042_delivery
, pg.cf08 pigflowid
from cftfeedorder FO (nolock)
inner join  
(select PigGroupId, ContactId, BinNbr  --, MillId
, max(datedel) as lastdel 
FROM solomonapp.dbo.cftFeedOrder (nolock)
where DateSched >= GETDATE()-90
and ordtype <> 'fl' 
group by PigGroupId, ContactId, BinNbr	--, MillId
) lastdelvrd      
    on lastdelvrd.PigGroupId = FO.PigGroupId
   and lastdelvrd.ContactId = FO.ContactId
   and lastdelvrd.BinNbr = FO.BinNbr
--   and lastdelvrd.MillId = FO.MillId
inner join
(select PigGroupId, ContactId, BinNbr
--, MillId
, Status, InvtIdDel
, max(datedel) as lastdel 
FROM solomonapp.dbo.cftFeedOrder (nolock)
where DateSched >= GETDATE()-90
and (InvtIdOrd like '041%' or InvtIdOrd like '042%' )
and InvtIdOrd <> '042M-NM' 
and Status in ('C','X') 
and ordtype <> 'fl'
group by PigGroupId, ContactId, BinNbr
--, MillId
, Status, InvtIdDel
) last042    
    on last042.PigGroupId = FO.PigGroupId
   and last042.ContactId = FO.ContactId
   and last042.BinNbr = FO.BinNbr
--   and last043.MillId = FO.MillId
left join SolomonApp.dbo.cftPigGroup PG (nolock)
      on PG.PigGroupID = FO.PigGroupId
INNER JOIN solomonapp.dbo.cftBin  b (nolock) 
      ON b.contactid = fo.ContactId
      and b.BinNbr = FO.BinNbr
INNER JOIN solomonapp.dbo.cftBinType bt (nolock)
      ON bt.BinTypeID = b.BinTypeID
where (fo.InvtIdOrd like '041%' or fo.InvtIdOrd like '043%' )	-- 2015-01-06
-- fo.InvtIdOrd like '043%' -- replaced 2015-01-06 sripley user request
and fo.Status not in ('X','C')
and FO.OrdType not like 'R1' 
and bt.Description not like 'creep%' 
and FO.commentid <> 'MT'
and lastdelvrd.lastdel = last042.lastdel
and fo.ordtype <> 'fl'









CREATE VIEW [dbo].[cfv_FeedOrder_043_051] 
(PigGroupId,pgdescription ,OrdNbr,BinNbr,DateSched,InvtIdOrd,qtyord
, binDescription, Status, CommentId, Comment, MillId, OrdType
, Prior_ration_delivered,Last_043_delivery)
AS
select 
FO.PigGroupId
,PG.description 
, FO.OrdNbr, FO.BinNbr, FO.DateSched, FO.InvtIdOrd, FO.qtyord
, bt.Description
, FO.Status, FO.CommentId, FO.Comment, FO.MillId, FO.OrdType
, last043.InvtIdDel Prior_ration_delivered,last043.lastdel as Last_043_delivery
from cftfeedorder FO (nolock)
inner join  
(select PigGroupId, ContactId, BinNbr  --, MillId
, max(datedel) as lastdel 
FROM solomonapp.dbo.cftFeedOrder (nolock)
where DateSched >= GETDATE()-90
--and Status in ('C','X') 
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
and InvtIdOrd like '043%' 
and InvtIdOrd <> '043M-NM' 
and Status in ('C','X') 
group by PigGroupId, ContactId, BinNbr
--, MillId
, Status, InvtIdDel
) last043     
    on last043.PigGroupId = FO.PigGroupId
   and last043.ContactId = FO.ContactId
   and last043.BinNbr = FO.BinNbr
--   and last043.MillId = FO.MillId
left join SolomonApp.dbo.cftPigGroup PG (nolock)
      on PG.PigGroupID = FO.PigGroupId
INNER JOIN solomonapp.dbo.cftBin  b (nolock) 
      ON b.contactid = fo.ContactId
      and b.BinNbr = FO.BinNbr
INNER JOIN solomonapp.dbo.cftBinType bt (nolock)
      ON bt.BinTypeID = b.BinTypeID
where fo.InvtIdOrd like '051%' 
and fo.Status  = 'O' 
and FO.OrdType not like 'R1' 
and bt.Description not like 'creep%' 
and FO.commentid <> 'MT'
and lastdelvrd.lastdel = last043.lastdel

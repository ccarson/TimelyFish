
-- Created 3/9/2016 by Jacque and Brian to help with managing feed changes and lockout processes
--                                  adapted from the view [cfv_FeedOrder_last042_curr043_not_FL]
/* 
========================================================================================================
Change Log: 
Date        Author		 	   	Change 
----------- ------------------ 	------------------------------------------------------------ 
5/11/2016	nhonetschlager		Changed to "53%" to allow different feeds that start with "53".
========================================================================================================
*/

CREATE VIEW [dbo].[cfv_BinTagQuery] 
(UpdateComment,PigGroupId,pgdescription ,OrdNbr,BinNbr,DateSched,InvtIdOrd,qtyord
, binDescription, Status, CommentId, Comment, MillId, OrdType
, Prior_ration_delivered,Last_delivery, pigflowid)
AS
    -- Change comment to T
	select 
		 'Change Order Comment to T' as 'UpdateComment'
	   , FO.PigGroupId
	   , PG.description 
	   , FO.OrdNbr
	   , FO.BinNbr
	   , FO.DateSched, FO.InvtIdOrd, FO.qtyord
	   , bt.Description
	   , FO.Status, FO.CommentId, FO.Comment, FO.MillId, FO.OrdType
	   , last042.InvtIdDel Prior_ration_delivered
	   , last042.lastdel as Last_delivery
	   , pg.cf08 pigflowid
	 from cftfeedorder FO (nolock)
	 inner join  (select ContactId, BinNbr
					   , max(datedel) as lastdel 
					FROM solomonapp.dbo.cftFeedOrder (nolock)
				   where DateSched >= GETDATE()-90 and ordtype <> 'fl' 
				group by ContactId, BinNbr	
				) lastdelvrd  on lastdelvrd.ContactId = FO.ContactId and lastdelvrd.BinNbr = FO.BinNbr
	 inner join (select ContactId, BinNbr
					  , Status, InvtIdDel
					  , max(datedel) as lastdel 
				   FROM solomonapp.dbo.cftFeedOrder (nolock)
				  where DateSched >= GETDATE()-90 and (InvtIdOrd like '041%' or InvtIdOrd like '042%' or InvtIdOrd like '043M' or InvtIdOrd like '043P')
					and InvtIdOrd <> '042M-NM' and Status in ('C','X') and ordtype <> 'fl'
			   group by ContactId, BinNbr, Status, InvtIdDel
			   ) last042 on last042.ContactId = FO.ContactId and last042.BinNbr = FO.BinNbr
	 left join SolomonApp.dbo.cftPigGroup PG (nolock) on PG.PigGroupID = FO.PigGroupId
	INNER JOIN solomonapp.dbo.cftBin  b (nolock) ON b.contactid = fo.ContactId and b.BinNbr = FO.BinNbr
	INNER JOIN solomonapp.dbo.cftBinType bt (nolock) ON bt.BinTypeID = b.BinTypeID
	where (   fo.InvtIdOrd like '043M-NM' or fo.InvtIdOrd like '044M-NM'  
		   or fo.InvtIdOrd like '051%'    or fo.InvtIdOrd like '052%'
		   or fo.InvtIdOrd like '053%'    or fo.InvtIdOrd like '054%'
		   or fo.InvtIdOrd like '055%'    or fo.InvtIdOrd like '056%'
		   or fo.InvtIdOrd like '057%'    or fo.InvtIdOrd like '058%'
		   or fo.InvtIdOrd like '075%'    or fo.InvtIdOrd like '011%'
		   or fo.InvtIdOrd like '012%'    or fo.InvtIdOrd like '013%'
		   or fo.InvtIdOrd like '014%'
		  )
	  and fo.Status not in ('X','C')
	  and FO.commentid <> 'T'
	  and lastdelvrd.lastdel = last042.lastdel
	  and fo.ordtype <> 'fl'

	union all
	-- Additional query to verify bins have tags in finish
	select 
	    'Change Order Comment to V' as 'UpdateComment'
	   , FO.PigGroupId
	   , PG.description 
	   , FO.OrdNbr
	   , FO.BinNbr
	   , FO.DateSched, FO.InvtIdOrd, FO.qtyord
	   , bt.Description
	   , FO.Status, FO.CommentId, FO.Comment, FO.MillId, FO.OrdType
	   , last042.InvtIdDel Prior_ration_delivered
	   , last042.lastdel as Last_delivery
	   , pg.cf08 pigflowid
	 from cftfeedorder FO (nolock)
	 inner join  (select ContactId, BinNbr
					   , max(datedel) as lastdel 
					FROM solomonapp.dbo.cftFeedOrder (nolock)
				   where DateSched >= GETDATE()-90 and ordtype <> 'fl' 
				group by ContactId, BinNbr	
				) lastdelvrd  on lastdelvrd.ContactId = FO.ContactId and lastdelvrd.BinNbr = FO.BinNbr
	 inner join (select ContactId, BinNbr
					  , Status, InvtIdDel
					  , max(datedel) as lastdel 
				   FROM solomonapp.dbo.cftFeedOrder (nolock)
				  where DateSched >= GETDATE()-90 
				    and (InvtIdOrd like '043M-NM' or InvtIdOrd like '044M-NM' or InvtIdOrd like '051%'
                      or InvtIdOrd like '052%'    or InvtIdOrd like '053%'    or InvtIdOrd like '054%'
                      or InvtIdOrd like '055%'    or InvtIdOrd like '056%'    or InvtIdOrd like '057%'
                      or InvtIdOrd like '058%'    or InvtIdOrd like '075%'    or InvtIdOrd like '011%'
                      or InvtIdOrd like '012%'    or InvtIdOrd like '013%'    or InvtIdOrd like '014%'
                        )
					and Status in ('C','X') and ordtype <> 'fl'
			   group by ContactId, BinNbr, Status, InvtIdDel
			   ) last042 on last042.ContactId = FO.ContactId and last042.BinNbr = FO.BinNbr
	 left join SolomonApp.dbo.cftPigGroup PG (nolock) on PG.PigGroupID = FO.PigGroupId
	INNER JOIN solomonapp.dbo.cftBin  b (nolock) ON b.contactid = fo.ContactId and b.BinNbr = FO.BinNbr
	INNER JOIN solomonapp.dbo.cftBinType bt (nolock) ON bt.BinTypeID = b.BinTypeID
	where (   fo.InvtIdOrd like '043M-NM' or fo.InvtIdOrd like '044M-NM'  
		   or fo.InvtIdOrd like '051%'    or fo.InvtIdOrd like '052%'
		   or fo.InvtIdOrd like '053%'    or fo.InvtIdOrd like '054%'
		   or fo.InvtIdOrd like '055%'    or fo.InvtIdOrd like '056%'
		   or fo.InvtIdOrd like '057%'    or fo.InvtIdOrd like '058%'
		   or fo.InvtIdOrd like '075%'    or fo.InvtIdOrd like '011%'
		   or fo.InvtIdOrd like '012%'    or fo.InvtIdOrd like '013%'
		   or fo.InvtIdOrd like '014%'
		  )
	  and fo.Status not in ('X','C')
	  and FO.commentid <> 'V'
	  and lastdelvrd.lastdel = last042.lastdel
	  and fo.ordtype <> 'fl'

	-- Additional Query to Remove the Tag and Verify the bin is empty
	Union all
	
	select 
	     'Change Order Comment to R' as 'UpdateComment'
	   , FO.PigGroupId
	   , PG.description 
	   , FO.OrdNbr
	   , FO.BinNbr
	   , FO.DateSched, FO.InvtIdOrd, FO.qtyord
	   , bt.Description
	   , FO.Status, FO.CommentId, FO.Comment, FO.MillId, FO.OrdType
	   , last042.InvtIdDel Prior_ration_delivered
	   , last042.lastdel as Last_delivery
	   , pg.cf08 pigflowid
	 from cftfeedorder FO (nolock)
	 inner join  (select ContactId, BinNbr
					   , max(datedel) as lastdel 
					FROM solomonapp.dbo.cftFeedOrder (nolock)
				   where DateSched >= GETDATE()-90 and ordtype <> 'fl' 
				group by ContactId, BinNbr	
				) lastdelvrd  on lastdelvrd.ContactId = FO.ContactId and lastdelvrd.BinNbr = FO.BinNbr
	 inner join (select ContactId, BinNbr
					  , Status, InvtIdDel
					  , max(datedel) as lastdel 
				   FROM solomonapp.dbo.cftFeedOrder (nolock)
				  where DateSched >= GETDATE()-90 
				    and (     InvtIdOrd like '043M-NM' or InvtIdOrd like '044M-NM'  
						   or InvtIdOrd like '051%'    or InvtIdOrd like '052%'
						   or InvtIdOrd like '053%'    or InvtIdOrd like '054%'
						   or InvtIdOrd like '055%'    or InvtIdOrd like '056%'
						   or InvtIdOrd like '057%'    or InvtIdOrd like '058%'
						   or InvtIdOrd like '075%'    or InvtIdOrd like '011%'
						   or InvtIdOrd like '012%'    or InvtIdOrd like '013%'
						   or InvtIdOrd like '014%'
                        )
					and Status in ('C','X') and ordtype <> 'fl'
			   group by ContactId, BinNbr, Status, InvtIdDel
			   ) last042 on last042.ContactId = FO.ContactId and last042.BinNbr = FO.BinNbr
	 left join SolomonApp.dbo.cftPigGroup PG (nolock) on PG.PigGroupID = FO.PigGroupId
	INNER JOIN solomonapp.dbo.cftBin  b (nolock) ON b.contactid = fo.ContactId and b.BinNbr = FO.BinNbr
	INNER JOIN solomonapp.dbo.cftBinType bt (nolock) ON bt.BinTypeID = b.BinTypeID
	where (   fo.InvtIdOrd like '041%' or fo.InvtIdOrd like '042%'  )
	  and fo.Status not in ('X','C')
	  and FO.commentid <> 'R'
	  and lastdelvrd.lastdel = last042.lastdel
	  and fo.ordtype <> 'fl'
	  


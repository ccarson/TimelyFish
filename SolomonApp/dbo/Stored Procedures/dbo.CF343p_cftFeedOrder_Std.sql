﻿Create Procedure CF343p_cftFeedOrder_Std @parm1 varchar (10), @parm2 varchar (6), @parm3 smalldatetime as 
    Select f.* from cftFeedOrder f Join cftFOSetUp u on 1 = 1
	left join cftSite s on f.ContactId = s.ContactId
	left join cftMilesMatrix m on m.AddressIdFrom = f.MillAddrId
	left join cftContact c on f.ContactId = c.ContactId
	Where f.PrtFlg = 3 and f.User6 = @parm1 and f.QtyOrd <> 0 and f.MillId = @parm2 and f.DateSched = @parm3
	and f.Status = 'O' and s.FeedOrderComments Not Like '%prewash%' 
	Order by f.DateSched, Case When u.RoadRestr = 1 then s.FeedTransferLocation Else '' End, s.FeedGrouping, 
	c.ContactName, f.BinNbr, m.AddressIdFrom

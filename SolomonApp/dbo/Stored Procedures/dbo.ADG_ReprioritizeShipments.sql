 CREATE PROCEDURE ADG_ReprioritizeShipments
	@InvtID varchar(30),
	@SiteID varchar(10)

AS

	select 	SOPlan.*, SOSched.PrioritySeq, SOHeader.CustID,
		SOHeader.ShipName, SOHeader.CustOrdNbr
	from 	(SOPlan
	  left join SOSched
		on (SOPlan.SOLineRef = SOSched.LineRef)
		and (SOPlan.SOSchedRef = SOSched.SchedRef)
		and (SOPlan.SOOrdNbr = SOSched.OrdNbr))
	  left join SOHeader
		ON (SOPlan.SOOrdNbr = SOHeader.OrdNbr)
	where	SOPlan.InvtID LIKE @InvtID
	  and	SOPlan.SiteID LIKE @SiteID
	order by SOPlan.DisplaySeq

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



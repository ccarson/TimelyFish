
--*************************************************************

--	Purpose:Market Totals for a specific date and week
--	Author: Charity Anderson
--	Date: 3/22/2005
--	Usage: Transporation Module
--	Parms: Date, CpnyID, SundayDate,PackerList
--	      
--*************************************************************
Create PROC [dbo].[pXT300PackerTotals_20150210]
		(@parm1 as smalldatetime,@parm2 as varchar(3), @parm3 as smalldatetime)

as
Select pt.ContactID,c.ContactName, 
(Select isnull(sum(estimatedqty),0) from 
cftPM WITH (NOLOCK) 
where MovementDate=@parm1
		and DestContactID=pt.ContactID
		and PMSystemID like @parm2
		and SuppressFlg=0 and PMTYpeID='02')  as TotalDay, TotalWeek
from cftPM pm WITH (NOLOCK) join
cftContact c on pm.DestContactID=c.ContactID

JOIN (Select DestContactID as ContactID,
		isnull(sum(pm.EstimatedQty),0) as TotalWeek
		from cftPM pm WITH (NOLOCK) 
		where pm.MovementDate between @parm3 and @parm3+6
		and pm.PMSystemID like @parm2
		and pm.SuppressFlg=0 and PMTYpeID='02'
		group by pm.DestContactID) as pt on pm.DestContactID=pt.ContactID
where pm.MovementDate between @parm3 and @parm3+6
		and pm.PMSystemID  like @parm2
		and pm.SuppressFlg=0 and PMTYpeID='02'

Group by pt.ContactID,c.ContactName,pt.TotalWeek
order by c.ContactName


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT300PackerTotals_20150210] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT300PackerTotals_20150210] TO [MSDSL]
    AS [dbo];


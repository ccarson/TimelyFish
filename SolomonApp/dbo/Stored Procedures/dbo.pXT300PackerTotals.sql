
--if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[pXT300PackerTotals]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
--drop procedure [dbo].[pXT300PackerTotals]
--GO

--*************************************************************

--	Purpose:Market Totals for a specific date and week
--	Author: Charity Anderson
--	Date: 3/22/2005
--	Usage: Transporation Module
--	Parms: Date, CpnyID, SundayDate,PackerList
--	      
--  Update: Added Order Number  - DDahle 2/10/2015
--*************************************************************
CREATE PROC [dbo].[pXT300PackerTotals]
		(@parm1 as smalldatetime,@parm2 as varchar(3), @parm3 as smalldatetime)

as
Select pm.destContactID as ContactID
, isnull(ord.descr,c.contactname) as ContactName,
(Select isnull(sum(estimatedqty),0) from 
cftPM WITH (NOLOCK) 
where MovementDate=@parm1
            and DestContactID=pm.destContactID
            and ordnbr = pm.ordnbr
            and PMSystemID like @parm2
            and SuppressFlg=0 and PMTYpeID='02')  as TotalDay, TotalWeek, pm.ordnbr as OrderNbr
from cftPM pm WITH (NOLOCK)
join cftContact c with (nolock) on pm.DestContactID=c.ContactID
left join [SolomonApp].[dbo].[cftPSOrdHdr] ord (nolock)
      on ord.ordnbr = pm.ordnbr and ord.pkrcontactid = c.contactid --and pm.movementdate between ord.firstdeldate and ord.lastdeldate
JOIN (Select DestContactID as ContactID,ordnbr,
            isnull(sum(pm.EstimatedQty),0) as TotalWeek
            from cftPM pm WITH (NOLOCK) 
            where pm.MovementDate between @parm3 and @parm3+6
            and pm.PMSystemID like @parm2
            and pm.SuppressFlg=0 and PMTYpeID='02'
            group by pm.DestContactID, ordnbr) as pt on pm.DestContactID=pt.ContactID and pt.ordnbr = pm.ordnbr
where pm.MovementDate between @parm3 and @parm3+6
            and pm.PMSystemID  like @parm2
            and pm.SuppressFlg=0 and PMTYpeID='02' 

Group by pm.destContactID, pm.ordnbr,isnull(ord.descr,c.contactname),pt.TotalWeek  
order by isnull(ord.descr,c.contactname)  



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT300PackerTotals] TO [SOLOMON]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT300PackerTotals] TO [MSDSL]
    AS [dbo];


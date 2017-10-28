

--*************************************************************
--	Purpose:Counts Site and responsiblity issues based on 
--		a specified week of date
--	Author: Charity Anderson
--	Date: 6/14/2005
--	Usage: Feed Order System Issues Report
--	Parms: WeekOfDate
--*************************************************************
/*
*******************************************************************
--	UPDATE:	Excluded specific issue types as requested by Jacque H. 
--	AUTHOR:	Nick Honetschlager
--	  DATE:	5/1/2014
*******************************************************************
*/
CREATE PROC [dbo].[pCF685SystemFOIssues]
		(@parm1 as char(10))

AS
Select c.ContactName as Site  ,v.RespPty,v.IssueType,(Sum(v.QtyDel)/2000) as Tons,
IssueCount=(Select Count(OrdNbr)
	from vCF685SystemFOIssues d 
	where 
	Site=v.Site and RespPty=v.RespPty and 
	DateDel between DateAdd(d,-29,@parm1) and DateAdd(d,-1,@parm1)),
SvcMgr=(Select TOP 1 c.ContactName 
		from cftSiteSvcMgrAsn sa JOIN cftContact c on sa.SvcMgrContactID=c.ContactID
		where SiteContactID=v.Site order by sa.EffectiveDate DESC)
FROM
vCF685SystemFOIssues v
LEFT JOIN cftContact c on v.Site=c.ContactID



where v.Site is not null
and v.DateDel between @parm1 and DateAdd(d,6,@parm1)
and IssueType NOT IN ('Manual Feed Managment','Flush Feed','Predictive Feed Ordering')		--Added 5/1/14 NJH
Group by c.ContactName,v.Site,v.IssueType,v.RespPty



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pCF685SystemFOIssues] TO [se\earth~solomonapp~datareader]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF685SystemFOIssues] TO [MSDSL]
    AS [dbo];


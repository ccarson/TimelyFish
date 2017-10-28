
--*************************************************************
--	Purpose:List of Sites for Schedule Report
--		
--	Author: Charity Anderson
--	Date: 4/13/2005
--	Usage: Transportation Module	 
--	Parms: StartDate, EndDate, CpnyID
--*************************************************************

CREATE PROC [dbo].[pXT300SiteList]
	(@parm1 as smalldatetime, @parm2 as smalldatetime, @parm3 as varchar(3))

AS
IF @Parm3='' BEGIN SET @Parm3='%' END
Select 'ALL' as ContactID,'<ALL>' as SiteName ,'' as TranschedMethTypeID
UNION
Select s.ContactID, rtrim(c.ContactName) as SiteName,c.TranSchedMethTypeID
FROM 
cftPM pm 
JOIN cftSite s on pm.SourceContactID=s.ContactID
JOIN cftContact c on s.ContactID=c.ContactID
where pm.MovementDate between @parm1 and @parm2 and pm.PMSystemID like @parm3
and (pm.Highlight <> 255 and pm.Highlight <> -65536)
--and pm.PMSystemID='01'

UNION
Select s.ContactID, rtrim(c.ContactName) as SiteName,c.TranSchedMethTypeID
FROM 
cftPM pm 
JOIN cftSite s on pm.DestContactID=s.ContactID
JOIN cftContact c on s.ContactID=c.ContactID
where pm.MovementDate between @parm1 and @parm2 and pm.PMSystemID like @parm3
and (pm.Highlight <> 255 and pm.Highlight <> -65536)
--and pm.PMSystemID='01'

UNION
Select c.ContactID, rtrim(c.ContactName) as SiteName,c.TranSchedMethTypeID
FROM 
cftPM pm 
JOIN cftContact c on pm.SourceContactID=c.ContactID
where pm.MovementDate between @parm1 and @parm2 and pm.PMSystemID like @parm3
and c.ContactID='000518'
and (pm.Highlight <> 255 and pm.Highlight <> -65536)
--and pm.PMSystemID='01'
Order by SiteName


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT300SiteList] TO [MSDSL]
    AS [dbo];


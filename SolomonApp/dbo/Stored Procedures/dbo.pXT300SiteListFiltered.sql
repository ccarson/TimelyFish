


--*************************************************************
--	Purpose:List of Filtered Sites for Schedule Report
--		
--	Author: Charity Anderson
--	Date: 4/13/2005
--	Usage: Transportation Module	 
--	Parms: StartDate, EndDate, CpnyID, SystemID
--      8/31/2006  (JM) corrected code to add CASE statement
--*************************************************************

CREATE PROC [dbo].[pXT300SiteListFiltered]
	(@parm1 as smalldatetime, @parm2 as smalldatetime, @parm3 as varchar(3),
	 @parm4 as varchar(2))

AS
IF @Parm3='' BEGIN SET @Parm3='%' END
Select s.ContactID, rtrim(c.ContactName) as SiteName,c.TranSchedMethTypeID
FROM 
cftPM pm 
JOIN cftSite s on pm.SourceContactID=s.ContactID
JOIN cftContact c on s.ContactID=c.ContactID
where pm.MovementDate between @parm1 and @parm2
and pm.PMSystemID like 
       (CASE @parm4
	  WHEN '00' THEN '0[^1]'
	ELSE
	  @parm4
	END)
UNION
Select s.ContactID, rtrim(c.ContactName) as SiteName,c.TranSchedMethTypeID
FROM 
cftPM pm 
JOIN cftSite s on pm.DestContactID=s.ContactID
JOIN cftContact c on s.ContactID=c.ContactID
where pm.MovementDate between @parm1 and @parm2 and (pm.Highlight <> 255 and pm.Highlight <> -65536)
and pm.PMSystemID like 
       (CASE @parm4
	  WHEN '00' THEN '0[^1]'
	ELSE
	  @parm4
	END)
Order by SiteName




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT300SiteListFiltered] TO [MSDSL]
    AS [dbo];


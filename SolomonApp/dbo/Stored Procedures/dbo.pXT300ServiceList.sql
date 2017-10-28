

--*************************************************************
--	Purpose:List of ServiceMen for Schedule Report
--		
--	Author: Charity Anderson
--	Date: 4/13/2005
--	Usage: Transportation Module	 
--	Parms: StartDate, EndDate, CpnyID
-- 
--  Updated 12 Nov 2015: Brian Diehl
--  Updated to remove inline function calls.  Performance went from 55seconds to 2.6 seconds.
--*************************************************************

CREATE PROC [dbo].[pXT300ServiceList]
	(@parm1 as smalldatetime, @parm2 as smalldatetime, @parm3 as varchar(3))

AS
IF @Parm3='' BEGIN SET @Parm3='%' END
--Select '' as ContactID,'<ALL>' as ServiceName ,'' as TranschedMethTypeID
--UNION
--Select Distinct dbo.GetSvcManager(pm.SourceContactID,@parm1,'') as ContactID, 
--dbo.GetSvcManagerNm(pm.SourceContactID,@parm1,'') as ServiceName,'' as transchedmethtypeid
--FROM 
--cftPM pm 
--where pm.MovementDate between @parm1 and @parm2 and pm.PMSystemID like @parm3
--and PMTYpeID='02'
--and dbo.GetSvcManager(pm.SourceContactID,@parm1,'') is not null
--UNION
--Select Distinct dbo.GetMarketSvcManager(pm.SourceContactID,@parm1,'') as ContactID, 
--dbo.GetMktManagerNm(pm.SourceContactID,@parm1,'') as ServiceName,'' as transchedmethtypeid
--FROM 
--cftPM pm 
--where pm.MovementDate between @parm1 and @parm2 and pm.PMSystemID like @parm3
--and PMTypeID='02'
--and dbo.GetMarketSvcManager(pm.SourceContactID,@parm1,'') is not null
--and (pm.Highlight <> 255 and pm.Highlight <> -65536)
--order by ServiceName

Select '' as ContactID,'<ALL>' as ServiceName ,'' as TranschedMethTypeID
UNION

	Select  contactInfo.UserID as ContactID
			,contactInfo.ContactName as ServiceName
			,'' as transchedmethtypeid
	FROM cftPM pm 
	Inner Join
			(SELECT sma.SiteContactID, ct.ContactID, ct.ContactName, e.UserID
				FROM dbo.cftSiteSvcMgrAsn sma
				JOIN cftEmployee e on sma.SvcMgrContactID=e.ContactID
				JOIN dbo.cftContact ct on sma.SvcMgrContactID=ct.ContactID
				WHERE sma.EffectiveDate = 
				( SELECT MAX(EffectiveDate) 
					FROM dbo.cftSiteSvcMgrAsn 
					WHERE SiteContactID = sma.SiteContactID AND EffectiveDate Between '1/1/1901' and @parm1 ) ) contactInfo 
			on contactInfo.SiteContactID=pm.SourceContactID					
	where pm.MovementDate between @parm1 and @parm2 and pm.PMSystemID like @parm3
		and PMTYpeID='02'

UNION
	Select  contactInfo.UserID as ContactID
		   ,contactInfo.ContactName as ServiceName
		   ,'' as transchedmethtypeid
	FROM cftPM pm 
	Inner Join
			 (SELECT sma.SiteContactID, ct.ContactID, ct.ContactName, e.UserID
				FROM dbo.cftMktMgrAssign sma
				JOIN dbo.cftContact ct on sma.MktMgrContactID=ct.ContactID
				JOIN cftEmployee e on sma.MktMgrContactID=e.ContactID
				WHERE sma.EffectiveDate = 
				( SELECT MAX(EffectiveDate) 
					FROM dbo.cftMktMgrAssign 
					WHERE SiteContactID = sma.SiteContactID AND EffectiveDate Between '1/1/1901' and @parm1 ) ) contactInfo 
			on contactInfo.SiteContactID=pm.SourceContactID
	where pm.MovementDate between @parm1 and @parm2 and pm.PMSystemID like @parm3
		and PMTypeID='02'
		and (pm.Highlight <> 255 and pm.Highlight <> -65536)
	order by ServiceName



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT300ServiceList] TO [MSDSL]
    AS [dbo];


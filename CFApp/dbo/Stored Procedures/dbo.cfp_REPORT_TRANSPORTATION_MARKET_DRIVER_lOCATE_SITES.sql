

--*************************************************************
--	Purpose:Data source for Market Schedule Driver Setup  Report
--		
--	Author: Doran Dahle
--	Date: 11/28/2011
--	Usage: Transportation SSRS Reports	 
--	Parms: MovementDate, @PMSystemID
--	
--	
--*************************************************************

Create PROC [dbo].[cfp_REPORT_TRANSPORTATION_MARKET_DRIVER_lOCATE_SITES]
	(@MovementDate as smalldatetime)

AS

Select Source, addr.addressid ,AddGeo.GeoRef
from 
(Select distinct s.ShortName as Source, ContactAddress.AddressID as addressid
from [$(SolomonApp)].dbo.cftPM pm
LEFT JOIN [$(SolomonApp)].dbo.cftContact s (NOLOCK) on pm.SourceContactID=s.ContactID 
INNER JOIN [$(CentralData)].dbo.ContactAddress ContactAddress (NOLOCK) ON ContactAddress.ContactID = s.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftWeekDefinition w (NOLOCK) on pm.MovementDate between w.WeekOfDate and w.WeekEndDate
LEFT JOIN [$(SolomonApp)].dbo.cftPMWeekStatus ws (NOLOCK) on w.WeekOfDate=ws.WeekOfDate and ws.PMTypeID='02' 
	and ws.PigSystemID='01' and ws.CpnyID='CFF'
LEFT JOIN [$(SolomonApp)].dbo.cftPMStatus st (NOLOCK) on ws.PMStatusID=st.PMStatusID and st.PMTypeID='02'
WHERE pm.MovementDate = @MovementDate
AND pm.PMSystemID like '%' and pm.PMTypeID='02'
and (pm.Highlight <> 255 and pm.Highlight <> -65536)
AND ContactAddress.AddressTypeID = 1) as addr
INNER JOIN [$(CentralData)].dbo.cft_Address_attrib AddGeo (NOLOCK) ON AddGeo.AddressID=addr.AddressID	
order by Source


GRANT EXECUTE ON cfp_REPORT_TRANSPORTATION_MARKET_DRIVER_lOCATE_SITES TO db_sp_exec


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_MARKET_DRIVER_lOCATE_SITES] TO [db_sp_exec]
    AS [dbo];


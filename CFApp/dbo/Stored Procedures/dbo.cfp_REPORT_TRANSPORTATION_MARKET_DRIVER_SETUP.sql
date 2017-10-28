
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

CREATE PROC [dbo].[cfp_REPORT_TRANSPORTATION_MARKET_DRIVER_SETUP]
	(@MovementDate as smalldatetime, @PMSystemID as varchar(3))

AS
IF @PMSystemID='' BEGIN SET @PMSystemID='%' END
DECLARE @PMSystem as varchar(2)
IF @PMSystemID='%' BEGIN SET @PMSystem='01' END else BEGIN SET @PMSystem=@PMSystemID end

Select pm.MovementDate,pm.ID,pm.PMID,pm.PMLoadID, s.ShortName as Source, pm.SourceBarnNbr, pm.SourceRoomNbr,
Case when CONVERT(float,pm.LoadingTime)>0 then
	SUBSTRING(CONVERT(CHAR(19),pm.LoadingTime,100),13,19) else '' end  as LoadTime,
Case when CONVERT(float,pm.ArrivalTime)>0 then
	SUBSTRING(CONVERT(CHAR(19),pm.ArrivalTime,100),13,19) else '' end  as ArriveTime,
EstimatedQty,EstimatedWgt,mt.Description as MarketType,pm.TrailerWashFlag,
d.ShortName as Destination, t.ShortName as Trucker,
pt.Description as Trailer, w.PICWeek,st.Description as ScheduleStatus,
ws.WeekOfDate,case when rtrim(pm.Comment)='' then Null else pm.comment end as Comment,pm.DisinfectFlg,
pm.Highlight
from [$(SolomonApp)].dbo.cftPM pm
LEFT JOIN [$(SolomonApp)].dbo.cftContact s on pm.SourceContactID=s.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact d on pm.DestContactID=d.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftMarketSaleType mt on pm.MarketSaleTypeID=mt.MarketSaleTypeID
LEFT JOIN [$(SolomonApp)].dbo.cftContact t on pm.TruckerContactID=t.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftPigTrailer pt on pm.PigTrailerID=pt.PigTrailerID
LEFT JOIN [$(SolomonApp)].dbo.cftWeekDefinition w on pm.MovementDate between w.WeekOfDate and w.WeekEndDate
LEFT JOIN [$(SolomonApp)].dbo.cftPMWeekStatus ws on w.WeekOfDate=ws.WeekOfDate and ws.PMTypeID='02' 
	and ws.PigSystemID=@PMSystem and ws.CpnyID='CFF'
LEFT JOIN [$(SolomonApp)].dbo.cftPMStatus st on ws.PMStatusID=st.PMStatusID and st.PMTypeID='02'

WHERE pm.MovementDate = @MovementDate 
      AND pm.PMSystemID like @PMSystemID and pm.PMTypeID='02'
and (pm.Highlight <> 255 and pm.Highlight <> -65536)
order by Source, pm.LoadingTime


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_TRANSPORTATION_MARKET_DRIVER_SETUP] TO [db_sp_exec]
    AS [dbo];


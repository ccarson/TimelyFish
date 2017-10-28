
--*************************************************************
--	Purpose:Data source for Site Schedule
--		
--	Author: Charity Anderson
--	Date: 4/8/2005
--	Usage: Transportation Module	 
--	Parms: StartDate, EndDate, CpnyID,SiteContactID
-- 9/10/2015  ddahle  		 Added company check on driver name.
--*************************************************************

CREATE PROC [dbo].[pXT300SiteSchedule]
	(@parm1 as smalldatetime, @parm2 as smalldatetime, @parm3 as varchar(3),
	@parm4 as varchar(6))

AS
DECLARE @SiteName as varchar(30), @PMSystem as varchar(2)
IF @Parm3='' BEGIN SET @Parm3='%' END
IF @Parm3='%' BEGIN SET @PMSystem='01' END else BEGIN SET @PMSystem=@PARM3 end
SET @SiteName=(Select ContactName from cftContact where ContactID=@parm4)

Select pm.MovementDate,pm.ID, s.ShortName as Source, pm.SourceBarnNbr, pm.SourceRoomNbr,
Case when CONVERT(float,pm.LoadingTime)>0 then
	SUBSTRING(CONVERT(CHAR(19),pm.LoadingTime,100),13,19) else '' end  as LoadTime,
Case when CONVERT(float,pm.ArrivalTime)>0 then
	SUBSTRING(CONVERT(CHAR(19),pm.ArrivalTime,100),13,19) else '' end  as ArriveTime,
EstimatedQty,Case when pm.PigTypeID<>'04' then mt.PigTypeDesc else mr.Description end as PigType,pm.CpnyID,
d.ShortName as Destination,pm.DestBarnNbr,pm.DestRoomNbr,
CASE WHEN dcpy.TruckingCompanyName IS NULL THEN t.ShortName ELSE dcpy.TruckingCompanyName END as Trucker,
pt.Description as Trailer, w.PICWeek,st.Description as ScheduleStatus,
ws.WeekOfDate,case when rtrim(pm.Comment)='' then Null else pm.comment end as Comment,
@SiteName as SiteName,pm.tattooflag,pm.LoadingTime,pm.ArrivalTime,pm.PigGenderTypeID,
TrailerWashFlag, GiltAge,pm.Highlight
from cftPM pm
LEFT JOIN cftContact s on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d on pm.DestContactID=d.ContactID
LEFT JOIN CentralData.dbo.cfv_DriverCompany dcpy (NOLOCK) on cast(pm.TruckerContactID as Integer) = dcpy.DriverContactID
LEFT JOIN cftPigType mt on pm.PigTypeID=mt.PigTypeID
LEFT JOIN cftMarketSaleType mr on pm.MarketSaleTypeID=mr.MarketSaleTypeID
LEFT JOIN cftContact t on pm.TruckerContactID=t.ContactID
LEFT JOIN cftPigTrailer pt on pm.PigTrailerID=pt.PigTrailerID
LEFT JOIN cftWeekDefinition w on pm.MovementDate between w.WeekOfDate and w.WeekEndDate
LEFT JOIN cftPMWeekStatus ws on w.WeekOfDate=ws.WeekOfDate and ws.PMTypeID='02' and ws.PigSystemID=@PMSystem and ws.CpnyID='CFF'
LEFT JOIN cftPMStatus st on ws.PMStatusID=st.PMStatusID and st.PMTypeID='02'

WHERE pm.MovementDate between @parm1 and @parm2
      AND pm.PMSystemID like @parm3 
	and (pm.DestContactID=@parm4 or pm.SourceContactID=@parm4)
	and pm.SuppressFlg=0
	and (pm.Highlight <> 255 and pm.Highlight <> -65536)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT300SiteSchedule] TO [MSDSL]
    AS [dbo];


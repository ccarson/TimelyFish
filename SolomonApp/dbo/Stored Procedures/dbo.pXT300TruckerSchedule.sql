
--*************************************************************
--	Purpose:Data source for Trucker Schedule
--		
--	Author: Charity Anderson
--	Date: 4/12/2005
--	Usage: Transportation Module	 
--	Parms: StartDate, EndDate, CpnyID,TruckerContactID
-- 9/10/2015  ddahle  		 Added company check on driver name.
--*************************************************************

CREATE PROC [dbo].[pXT300TruckerSchedule]
	(@parm1 as smalldatetime, @parm2 as smalldatetime, @parm3 as varchar(3),
	@parm4 as varchar(6))

AS
DECLARE @PMSystem as varchar(2)
IF @Parm3='' BEGIN SET @Parm3='%' END
IF @Parm3='%' BEGIN SET @PMSystem='01' END else BEGIN SET @PMSystem=@PARM3 end
Select pm.MovementDate,pm.ID, s.ShortName as Source, pm.SourceBarnNbr, pm.SourceRoomNbr,
Case when CONVERT(float,pm.LoadingTime)>0 then
	SUBSTRING(CONVERT(CHAR(19),pm.LoadingTime,100),13,19) else '' end  as LoadTime,
Case when CONVERT(float,pm.ArrivalTime)>0 then
	SUBSTRING(CONVERT(CHAR(19),pm.ArrivalTime,100),13,19) else '' end  as ArriveTime,
EstimatedQty,
Case when pm.PigTypeID<>'04' then mt.PigTypeDesc else mr.Description end as PigType,
CASE WHEN dcpy.TruckingCompanyName IS NULL THEN t.ShortName ELSE dcpy.TruckingCompanyName + ' - ' +t.ShortName END as Trucker,
pm.CpnyID,
d.ShortName as Destination,pm.DestBarnNbr,pm.DestRoomNbr, 
pt.Description as Trailer, w.PICWeek,st.Description as ScheduleStatus,
ws.WeekOfDate,case when rtrim(pm.Comment)='' then Null else pm.comment end as Comment,
pm.tattooflag,p.TrkPaidFlg,pm.TrailerWashFlag,pm.DisinfectFlg,
Rate = --case when trkpaidflg=0 then 0 
	--else 
dbo.getRate(pm.PMLoadID,pm.PMID,w.WeekOfDate,pm.PigTypeID,pm.PMSystemID,pm.PigTrailerID,pm.TranSubTypeID),
pm.LoadingTime,pm.ArrivalTime ,pm.PigGenderTypeID,pm.highlight
--end
from cftPM pm
LEFT JOIN cftContact s on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d on pm.DestContactID=d.ContactID
LEFT JOIN cftContact t on pm.TruckerContactID=t.ContactID
LEFT JOIN CentralData.dbo.cfv_DriverCompany dcpy (NOLOCK) on cast(pm.TruckerContactID as Integer) = dcpy.DriverContactID
LEFT JOIN cftPigType mt on pm.PigTypeID=mt.PigTypeID
LEFT JOIN cftPigTrailer pt on pm.PigTrailerID=pt.PigTrailerID
LEFT JOIN cftPacker p on pm.DestContactID=p.ContactID
LEFT JOIN cftMarketSaleType mr on pm.MarketSaleTypeID=mr.MarketSaleTypeID
LEFT JOIN cftWeekDefinition w on pm.MovementDate between w.WeekOfDate and w.WeekEndDate
LEFT JOIN cftPMWeekStatus ws on w.WeekOfDate=ws.WeekOfDate and ws.PMTypeID='02' and ws.PigSystemID=@PMSystem and ws.CpnyID='CFF'
LEFT JOIN cftPMStatus st on ws.PMStatusID=st.PMStatusID and st.PMTypeID='02'

WHERE pm.MovementDate between @parm1 and @parm2
      	AND pm.PMSystemID like @parm3 
	and TruckerContactID=@parm4
	and pm.SuppressFlg=0
	and (pm.Highlight <> 255 and pm.Highlight <> -65536)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT300TruckerSchedule] TO [MSDSL]
    AS [dbo];


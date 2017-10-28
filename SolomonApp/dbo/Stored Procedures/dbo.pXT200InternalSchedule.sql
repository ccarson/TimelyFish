
--*************************************************************
--	Purpose:Data source for Internal Schedule
--		
--	Author: Charity Anderson
--	Date: 4/13/2005
--	Usage: Transportation Module	 
--	Parms: StartDate, EndDate, CpnyID, PigSystem

--*************************************************************

CREATE PROC [dbo].[pXT200InternalSchedule]
	(@parm1 as smalldatetime, @parm2 as smalldatetime, @parm3 as varchar(3),
	 @parm4 as varchar(2))

AS
DECLARE @PMSystem as varchar(2)
IF @Parm3='' BEGIN SET @Parm3='%' END
IF @Parm3='%' BEGIN SET @PMSystem='01' END else BEGIN SET @PMSystem=@PARM3 end
Select pm.MovementDate,pm.ID, s.ShortName as Source, pm.SourceBarnNbr, pm.SourceRoomNbr,
Case when CONVERT(float,pm.LoadingTime)>0 then
	SUBSTRING(CONVERT(CHAR(19),pm.LoadingTime,100),13,19) else '' end  as LoadTime,
Case when CONVERT(float,pm.ArrivalTime)>0 then
	SUBSTRING(CONVERT(CHAR(19),pm.ArrivalTime,100),13,19) else '' end  as ArriveTime,
EstimatedQty,EstimatedWgt,mt.PigTypeDesc as PigType,pm.TrailerWashFlag,pm.CpnyID,
d.ShortName as Destination,pm.DestBarnNbr,pm.DestRoomNbr,
t.ShortName as Trucker,
pt.Description as Trailer, w.PICWeek,st.Description as ScheduleStatus,pm.TattooFlag,
ws.WeekOfDate,case when rtrim(pm.Comment)='' then Null else pm.comment end as Comment,
pm.DisinfectFlg,pm.LoadingTime,pm.ArrivalTime,pm.Highlight,PigGenderTypeID,pm.PMSystemID,pm.GiltAge
from cftPM pm
LEFT JOIN cftContact s on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d on pm.DestContactID=d.ContactID
LEFT JOIN cftPigType mt on pm.PigTypeID=mt.PigTypeID
LEFT JOIN cftContact t on pm.TruckerContactID=t.ContactID
LEFT JOIN CentralData.dbo.cfv_DriverCompany dcpy (NOLOCK) on cast(pm.TruckerContactID as Integer) = dcpy.DriverContactID
LEFT JOIN cftPigTrailer pt on pm.PigTrailerID=pt.PigTrailerID
LEFT JOIN cftWeekDefinition w on pm.MovementDate between w.WeekOfDate and w.WeekEndDate
LEFT JOIN cftPMWeekStatus ws on w.WeekOfDate=ws.WeekOfDate and ws.PMTypeID='02' and ws.PigSystemID=@PMSystem and ws.CpnyID='CFF'
LEFT JOIN cftPMStatus st on ws.PMStatusID=st.PMStatusID and st.PMTypeID='01'

WHERE pm.MovementDate between @parm1 and @parm2
      AND pm.PMSystemID like @parm3 and pm.PMTypeID='01'
	  --pm.PMSystemID=@parm4
	  and (pm.Highlight <> 255 and pm.Highlight <> -65536)
--and pm.PMSystemID='01'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT200InternalSchedule] TO [MSDSL]
    AS [dbo];






--*************************************************************
--	Purpose:Data source for Market Schedule
--		
--	Author: Charity Anderson
--	Date: 4/8/2005
--	Usage: Transportation Module	 
--	Parms: StartDate, EndDate, CpnyID
--	
--	Rev. A  10/10/06 (jrm)  added PFEU field 
--	Rev. B  08/27/07 (md)	added coalesces for null comparisons
--*************************************************************

CREATE PROC [dbo].[pXT300MarketSchedule_20150318]
	(@parm1 as smalldatetime, @parm2 as smalldatetime, @parm3 as varchar(3),
	 @parm4 as varchar(10))

AS
IF @Parm3='' BEGIN SET @Parm3='%' END
DECLARE @UserID as varchar(11), @PMSystem as varchar(2)
IF @Parm3='%' BEGIN SET @PMSystem='01' END else BEGIN SET @PMSystem=@PARM3 end
SET @UserID=rtrim(@parm4) + '%'
Select pm.MovementDate,pm.ID, s.ShortName as Source, pm.SourceBarnNbr, pm.SourceRoomNbr,
Case when CONVERT(float,pm.LoadingTime)>0 then
	SUBSTRING(CONVERT(CHAR(19),pm.LoadingTime,100),13,19) else '' end  as LoadTime,
Case when CONVERT(float,pm.ArrivalTime)>0 then
	SUBSTRING(CONVERT(CHAR(19),pm.ArrivalTime,100),13,19) else '' end  as ArriveTime,
EstimatedQty,EstimatedWgt,mt.Description as MarketType,pm.TrailerWashFlag,
d.ShortName as Destination,pm.DestBarnNbr,pm.DestRoomNbr, t.ShortName as Trucker,
pt.Description as Trailer, w.PICWeek,st.Description as ScheduleStatus,
ws.WeekOfDate,case when rtrim(pm.Comment)='' then Null else pm.comment end as Comment,pm.DisinfectFlg,
pm.CpnyID,pm.LoadingTime,pm.ArrivalTime,pm.Highlight,pm.ActualQty, pm.ActualWgt, pm.PFEUEligible as PFEU
from cftPM pm
LEFT JOIN cftContact s on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d on pm.DestContactID=d.ContactID
LEFT JOIN cftMarketSaleType mt on pm.MarketSaleTypeID=mt.MarketSaleTypeID
LEFT JOIN cftContact t on pm.TruckerContactID=t.ContactID
LEFT JOIN cftPigTrailer pt on pm.PigTrailerID=pt.PigTrailerID
LEFT JOIN cftWeekDefinition w on pm.MovementDate between w.WeekOfDate and w.WeekEndDate
LEFT JOIN cftPMWeekStatus ws on w.WeekOfDate=ws.WeekOfDate and ws.PMTypeID='02' 
	and ws.PigSystemID=@PMSystem and ws.CpnyID='CFF'
LEFT JOIN cftPMStatus st on ws.PMStatusID=st.PMStatusID and st.PMTypeID='02'

WHERE pm.MovementDate between @parm1 and @parm2
      AND pm.PMSystemID like @parm3 and pm.PMTypeID='02'
     -- AND pm.DestContactID<>'000816'
and (COALESCE(dbo.GetMarketSvcManager(pm.SourceContactID,@parm1,''),'NA') like @UserID
	or COALESCE(dbo.GetSvcManager(pm.SourceContactID,@parm1,''),'NA') like @UserID
	or COALESCE(dbo.GetMarketSvcManager(pm.DestContactID,@parm1,''),'NA') like @UserID
	or COALESCE(dbo.GetSvcManager(pm.DestContactID,@parm1,''),'NA') like @UserID
	or pm.Crtd_User like @parm4)
and (pm.Highlight <> 255 and pm.Highlight <> -65536)
--and pm.PMSystemID='01'




GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT300MarketSchedule_20150318] TO [MSDSL]
    AS [dbo];


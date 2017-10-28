



--*************************************************************
--	Purpose:Data source for Packer Schedule
--		
--	Author: Charity Anderson
--	Date: 4/12/2005
--	Usage: Transportation Module	 
--	Parms: StartDate, EndDate, CpnyID,PackerContactID
--	
--	Rev. A  10/10/06 (jrm)  added PFEU field 
--*************************************************************

CREATE PROC [dbo].[pXT300PackerSchedule_20150121]
	(@parm1 as smalldatetime, @parm2 as smalldatetime, @parm3 as varchar(3),
	@parm4 as varchar(6))

AS
DECLARE @PMSystem as varchar(2)
IF @Parm3='' BEGIN SET @Parm3='%' END
IF @Parm3='%' BEGIN SET @PMSystem='01' END else BEGIN SET @PMSystem=@PARM3 end
Select pm.MovementDate,pm.ArrivalDate,pm.ID, s.ShortName as Source, pm.SourceBarnNbr, pm.SourceRoomNbr,
Case when CONVERT(float,pm.LoadingTime)>0 then
	SUBSTRING(CONVERT(CHAR(19),pm.LoadingTime,100),13,19) else '' end  as LoadTime,
Case when CONVERT(float,pm.ArrivalTime)>0 then
	SUBSTRING(CONVERT(CHAR(19),pm.ArrivalTime,100),13,19) else '' end  as ArriveTime,
EstimatedQty,mt.Description as PigType,t.ShortName as Trucker,pm.CpnyID,
d.ShortName as Destination,pm.DestBarnNbr,pm.DestRoomNbr, 
pt.Description as Trailer, w.PICWeek,st.Description as ScheduleStatus,
ws.WeekOfDate,case when rtrim(pm.Comment)='' then Null else pm.comment end as Comment,
pm.tattooflag,p.TrkPaidFlg,pm.TrailerWashFlag,pm.DisinfectFlg,a.State,pm.EstimatedWgt,
Rate = --case when trkpaidflg=0 then 0 
	--else 
dbo.getRate(pm.PMLoadID,pm.PMID,w.WeekOfDate,pm.PigTypeID,pm.PMSystemID,pm.PigTrailerID,pm.TranSubTypeID),
pm.LoadingTime,pm.ArrivalTime,pm.Highlight, pm.PFEUEligible as PFEU
--end
from cftPM pm
LEFT JOIN cftContact s on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d on pm.DestContactID=d.ContactID
LEFT JOIN cftContact t on pm.TruckerContactID=t.ContactID
LEFT JOIN cftMarketSaleType mt on pm.MarketSaleTypeID=mt.MarketSaleTypeID
LEFT JOIN cftPigTrailer pt on pm.PigTrailerID=pt.PigTrailerID
LEFT JOIN cftPacker p on pm.DestContactID=p.ContactID
LEFT JOIN cftWeekDefinition w on pm.MovementDate between w.WeekOfDate and w.WeekEndDate
LEFT JOIN cftPMWeekStatus ws on w.WeekOfDate=ws.WeekOfDate and ws.PMTypeID='02' and ws.PigSystemID=@PMSystem and ws.CpnyID='CFF'
LEFT JOIN cftPMStatus st on ws.PMStatusID=st.PMStatusID  and st.PMTypeID='02'
LEFT JOIN cftContactAddress ca on pm.SourceContactID=ca.ContactID and AddressTypeID='01'
LEFT JOIN cftAddress a on ca.AddressID=a.AddressID

WHERE pm.MovementDate between @parm1 and @parm2
      	AND pm.PMSystemID like @parm3 
	and DestContactID=@parm4
	and pm.SuppressFlg=0
	and (pm.Highlight <> 255 and pm.Highlight <> -65536)
--and pm.PMSystemID='01'




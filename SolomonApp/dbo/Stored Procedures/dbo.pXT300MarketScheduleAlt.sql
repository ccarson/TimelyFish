
--*************************************************************
--	Purpose:Data source for Market Schedule Alternative	
--		Markets
--	Author: Charity Anderson
--	Date: 4/11/2005
--	Usage: Transportation Module	 
--	Parms: StartDate, CpnyID
--
--	Rev A.	08/27/07 (md)	added coalesces for null value comparisons Mantis 539
--*************************************************************

CREATE PROC dbo.pXT300MarketScheduleAlt
	(@parm1 as smalldatetime, @parm2 as smalldatetime, @parm3 as varchar(3),
	 @parm4 as varchar(10))

AS

DECLARE @UserID as varchar(11)
SET @UserID=rtrim(@parm4) + '%'
IF @Parm3='' BEGIN SET @Parm3='%' END
Select pm.MovementDate,pm.ID, s.ShortName as Source, pm.SourceBarnNbr, pm.SourceRoomNbr,
Case when CONVERT(float,pm.LoadingTime)>0 then
	SUBSTRING(CONVERT(CHAR(19),pm.LoadingTime,100),13,19) else '' end  as LoadTime,
Case when CONVERT(float,pm.ArrivalTime)>0 then
	SUBSTRING(CONVERT(CHAR(19),pm.ArrivalTime,100),13,19) else '' end  as ArriveTime,
EstimatedQty,EstimatedWgt,mt.Description as MarketType,pm.TrailerWashFlag,
d.ShortName as Destination,pm.DestBarnNbr,pm.DestRoomNbr, t.ShortName as Trucker,pm.CpnyID,
pt.Description as Trailer,
case when rtrim(pm.Comment)='' then Null else pm.comment end as Comment,pm.DisinfectFlg,
pm.LoadingTime,pm.ArrivalTime

from cftPM pm
LEFT JOIN cftContact s on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact d on pm.DestContactID=d.ContactID
LEFT JOIN cftMarketSaleType mt on pm.MarketSaleTypeID=mt.MarketSaleTypeID
LEFT JOIN cftContact t on pm.TruckerContactID=t.ContactID
LEFT JOIN cftPigTrailer pt on pm.PigTrailerID=pt.PigTrailerID


WHERE pm.MovementDate between @parm1  and @parm2
      AND pm.PMSystemID like @parm3 and pm.PMTypeID='02'
      AND pm.DestContactID='000816'
and (COALESCE(dbo.GetMarketSvcManager(pm.SourceContactID,@parm1,''),'NA') like @UserID
	or COALESCE(dbo.GetSvcManager(pm.SourceContactID,@parm1,''),'NA') like @UserID
	or COALESCE(dbo.GetMarketSvcManager(pm.DestContactID,@parm1,''),'NA') like @UserID
	or COALESCE(dbo.GetSvcManager(pm.DestContactID,@parm1,''),'NA') like @UserID
	or pm.Crtd_User like @parm4)
--and pm.PMSystemID='01'


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT300MarketScheduleAlt] TO [SOLOMON]
    AS [dbo];


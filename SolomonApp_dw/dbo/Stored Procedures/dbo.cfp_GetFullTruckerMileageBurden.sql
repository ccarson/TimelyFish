
-- ===================================================================
-- Author:	Brian Diehl
-- Create date: 02/27/2014
-- Description:	Returns information about loads including total deadhead miles
--              Written for Jason W. in transportation for use in a XLS file
-- ===================================================================
CREATE procedure dbo.cfp_GetFullTruckerMileageBurden 
       @beginDate date, 
       @endDate date
AS
BEGIN
create table #schedule (
  MovementDate date,
  PicWeek varchar(2),
  PMID int,
  PMLoadID int,
  Source varchar(30),
  SourceContactId varchar(6),
  SourceBarnNbr int,
  SourceRoomNbr varchar(8),
  LoadTime time,
  ArriveTime time,
  EstimatedQty int,
  PigType varchar(12),
  TruckerID varchar(6),
  TruckerName varchar(30),
  Destination varchar(30),
  DestContactId varchar(6),
  DestBarnNbr int,
  DestRoomNbr varchar(6),
  Trailer varchar(6),
  Rate decimal,
  Miles decimal
)

insert into #schedule
Select 
	convert(DATE, cftPM.MovementDate) as 'MovementDate',
	cftWeekDefinition.PicWeek,
	cftPM.ID as 'PMID', cftpm.pmloadid as 'PMLoadID',
	SourceContact.ShortName as Source, 
	SourceContact.ContactID as 'SourceContactid',
	cftPM.SourceBarnNbr, 
	cftPM.SourceRoomNbr,
	Case when LEN(RTRIM(cftPM.LoadingTime))>0 
		then convert(char, cftPM.LoadingTime, 108) 
		else '' 
	end  as LoadTime,
	Case when LEN(RTRIM(cftPM.ArrivalTime))>0 
		then convert(char, cftPM.ArrivalTime, 108) 
		else '' 
	end  as ArriveTime,
	EstimatedQty,
	Case when cftPM.PigTypeID<>'04' 
		then cftPigType.PigTypeDesc 
		else cftMarketSaleType.Description 
	end as PigType,(TruckerContact.Contactid) as 'TruckerID',
	LEFT(RTRIM(TruckerContact.ContactName),30) as 'TruckerName',
	DestContact.ShortName as Destination,
	cftPM.destcontactid,
	cftPM.DestBarnNbr,
	cftPM.DestRoomNbr, 
	isnull(cftPigTrailer.Description,'') as Trailer, 
	[$(SolomonApp)].dbo.getRate(cftPM.PMLoadID,cftPM.PMID,cftWeekDefinition.WeekOfDate,cftPM.PigTypeID,cftPM.PMSystemID,cftPM.PigTrailerID,cftPM.TranSubTypeID) as 'Rate',
    [$(SolomonApp)].dbo.getMiles(cftPM.PMLoadID) as Miles

from [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
LEFT JOIN [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK) on cftPM.SourceContactID = SourceContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK) on cftPM.DestContactID = DestContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact TruckerContact (NOLOCK) on cftPM.TruckerContactID = TruckerContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftPigType cftPigType (NOLOCK) on cftPM.PigTypeID = cftPigType.PigTypeID
LEFT JOIN [$(SolomonApp)].dbo.cftPigTrailer cftPigTrailer (NOLOCK) on cast(cftPM.PigTrailerID as int) = cast(cftPigTrailer.PigTrailerID as int)
LEFT JOIN [$(SolomonApp)].dbo.cftPacker cftPacker (NOLOCK) on cftPM.DestContactID = cftPacker.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftMarketSaleType cftMarketSaleType (NOLOCK) on cftPM.MarketSaleTypeID = cftMarketSaleType.MarketSaleTypeID
LEFT JOIN [$(SolomonApp)].dbo.cftWeekDefinition cftWeekDefinition (NOLOCK) on cftPM.MovementDate between cftWeekDefinition.WeekOfDate and cftWeekDefinition.WeekEndDate
LEFT JOIN [$(SolomonApp)].dbo.cftPMWeekStatus cftPMWeekStatus (NOLOCK) on cftWeekDefinition.WeekOfDate = cftPMWeekStatus.WeekOfDate 
	and cftPMWeekStatus.PMTypeID = '02' 
	and cftPMWeekStatus.PigSystemID = '00' 
	and cftPMWeekStatus.CpnyID='CFF'
left join (select s.contactid, c.contactname		-- use Nancy Rush phone number 507-227-8043 if multiplication site
	from [$(SolomonApp)].dbo.cftSite s (nolock)
	inner join [$(CentralData)].dbo.Contact c (nolock) on c.contactid = s.contactid
	where s.pigsystemid = '00') mulip on mulip.contactid = cftPM.destcontactid 
WHERE cftPM.MovementDate between @beginDate and @endDate and cftPM.PMSystemID like '%' and cftPM.PMTypeID = '02'
	and cftPM.SuppressFlg = 0
	and cftPM.Highlight <> 255
	and cftPM.Highlight <> -65536

;WITH ScheduleData AS
(
    SELECT MovementDate, PicWeek, PMID, PMLoadID, Source,
           SourceContactId, SourceBarnNbr, SourceRoomNbr,
           LoadTime, ArriveTime, EstimatedQty, PigType,
           TruckerID, TruckerName , Destination,
           DestContactId, DestBarnNbr, DestRoomNbr,
           Trailer, Rate, Miles, 
        ROW_NUMBER() OVER (PARTITION BY truckerID, Trailer, PicWeek ORDER BY MovementDate ASC) AS ROWID
    FROM #schedule
)
SELECT a.TruckerName, a.truckerid, a.trailer, a.picweek, a.SourceContactID as 'LoadSource', a.Source as SourceName, 
       a.DestContactID as 'LoadDestination', a.Destination as 'DestinationName', a.DestBarnNbr, a.DestRoomNbr, 
       isnull(b.SourceContactID,'Home') as ReturnDest, isnull(b.source,'Home') as 'ReturnDestName',
       a.rate as 'LoadRate', a.miles as 'LoadedMiles',
       isnull(c.OneWayMiles,'-1') as 'DeadHeadMiles', a.MovementDate, a.PMID, a.PMLoadID,
       a.SourceBarnNbr, a.SourceRoomNbr, a.LoadTime, a.ArriveTime, a.EstimatedQty, a.PigType,
       a.RowID
FROM ScheduleData A
LEFT JOIN ScheduleData b on a.truckerid=b.truckerid and a.trailer=b.trailer and a.rowid+1=b.rowid and a.picweek = b.picweek
left join [$(SolomonApp)].dbo.vcfContactMilesMatrix c on SourceSite=a.destcontactid and DestSite=isnull(b.sourcecontactid,a.truckerid)
union
SELECT a.TruckerName, a.truckerid, a.trailer, a.picweek, 'Home' as 'LoadSource', 'Home' as 'SourceName',
       a.SourceContactID as 'LoadDestination', a.Source as 'DestinationName', a.DestBarnNbr, a.DestRoomNbr,
       NULL as ReturnDest, Null as ReturnDestName,
       0 as 'LoadRate', 0 as 'LoadedMiles',
       isnull(c.OneWayMiles,'-1') as 'ReturnMiles', NULL as MovementDate, NULL as PID, a.pmloadid as PMLoadID,
       NULL as SourceBarnNbr, NULL as SourceRoomNbr, NULL as LoadTime, NULL as ArriveTime, NULL as EstimatedQty, NULL as PigType,
       a.RowID-1
FROM ScheduleData A
left join [$(SolomonApp)].dbo.vcfContactMilesMatrix c on SourceSite=a.truckerid and DestSite=a.sourcecontactid
where a.rowid=1
order by 2, 3, 4, 25

drop table #schedule

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_GetFullTruckerMileageBurden] TO [db_sp_exec]
    AS [dbo];


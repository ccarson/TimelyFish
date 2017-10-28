-- =============================================
-- Author:		Doran Dahle, Dan Marti
-- Create date: 04/05/2016
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[cfp_Load_Miles]  
	@StartDate DATETIME,
@EndDate DATETIME
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
create table #loads (
  PMLoadID varchar(10),
  PMID varchar(10),
  MovementDate smalldatetime,
  Source varchar(30),
  Dest varchar(30),
  Category varchar(20),
  Rate Decimal(10,2),
  Miles Decimal(10,2),
  Fuel Decimal(10,2),
  EstimatedQty SmallInt,
  ActualQty SmallInt,
  WeekOfDate smalldatetime)

insert into #loads 

select PM.PMLoadID
            ,PM.PMID
                  ,PM.MovementDate
            ,SourceContact.ShortName as Source
            ,DestContact.ShortName as Destination
            ,Category = CASE PM.PigTypeID
                    WHEN '02' THEN 'Wean'
                    WHEN '03' THEN 'Feeder'
                    WHEN '04' THEN 'Market'
                    WHEN '07' THEN 'Market'
                    WHEN '05' THEN 'Cull Sow'
                    WHEN '06' THEN 'Breeding Movement'
                    WHEN '08' THEN 'Breeding Movement'
                    WHEN '09' THEN 'Breeding Movement'
                    WHEN '10' THEN 'Breeding Movement'
                    WHEN '11' THEN 'Breeding Movement'
                    WHEN '12' THEN 'Breeding Movement'
                        ELSE 'Other'
                              END
            ,[$(SolomonApp)].dbo.getRate(PM.PMLoadID
                        ,PM.PMID
                        ,w.WeekOfDate
                        ,PM.PigTypeID
                        ,PM.PMSystemID
                        ,PM.PigTrailerID
                        ,PM.TranSubTypeID) as Rate
            ,[$(SolomonApp)].dbo.getRateMiles(PM.PMLoadID
                        ,PMID) as Miles
            ,[$(SolomonApp)].dbo.getRateFuelSurcharge(PM.PMLoadID
                        ,PM.PMID
                        ,w.WeekOfDate) as FuelSurcharge
            ,EstimatedQty
            ,ActualQty
                  ,w.WeekOfDate as weekofDate
                  
from [$(SolomonApp)].dbo.cftPm PM
LEFT JOIN [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK) on PM.SourceContactID = SourceContact.ContactID
LEFT JOIN [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK) on PM.DestContactID = DestContact.ContactID
Left join [$(SolomonApp)].dbo.cftWeekDefinition w on PM.MovementDate between w.WeekOfDate and w.WeekEndDate
      
where (PM.Highlight <> 255 and PM.Highlight <> -65536)  and PM.MovementDate between @StartDate and @EndDate 
and (SourceContactID not in (
		  '002526' , '005424' , '005541' , '002536' , '002539' , '002686' , '002545' , '004184' , '004304' , '004185' , '004742' 
		, '002547' , '002548' , '002549' , '002550' , '002551' , '002552' , '002553' , '004314' , '006767' , '002566' , '002567' 
		, '002837' , '002573' , '002575' , '002576' , '006857' , '002580' , '009520' , '004242' , '003903' , '003905' , '004313' 
		, '004247' , '004309' , '004292' , '004210' , '004442' , '004432' , '004426' , '004414' , '004413' , '004415' , '004416' 
		, '004417' , '004595' , '004614' , '004615' , '004849' , '002597' , '004418' , '004396' , '002582' , '002583' , '002589' 
		, '002308' , '002592' , '005565' , '002595' , '008965' , '010493' , '005446' , '002601' , '002602' , '004300' , '002604' 
		, '002606' , '002605' , '010141' , '007947' , '002610' , '009030' , '002615' , '005121' , '002617' , '002619' , '009029' 
		, '002625' , '002626' , '002306' , '002627' , '010708' , '010709' , '002632' , '002616' , '002651' , '003529' , '003530' 
		, '003692' , '003700' , '003697' , '003701' , '003702' , '002633' , '002637' , '002640' , '002642' , '002645' , '002646' 
		, '009674' , '002648' , '004397' , '003768' , '002649' , '002652' , '002654' , '010732' , '009355' , '009359' , '009360'
		, '007207' , '002656' , '002657' , '002659' , '002660' , '008123' , '008122' , '006727' , '002666' , '002667' , '002668' 
		, '009677' , '006615' 
		) or DestContactID not in (
		  '002526' , '005424' , '005541' , '002536' , '002539' , '002686' , '002545' , '004184' , '004304' , '004185' , '004742' 
		, '002547' , '002548' , '002549' , '002550' , '002551' , '002552' , '002553' , '004314' , '006767' , '002566' , '002567' 
		, '002837' , '002573' , '002575' , '002576' , '006857' , '002580' , '009520' , '004242' , '003903' , '003905' , '004313' 
		, '004247' , '004309' , '004292' , '004210' , '004442' , '004432' , '004426' , '004414' , '004413' , '004415' , '004416' 
		, '004417' , '004595' , '004614' , '004615' , '004849' , '002597' , '004418' , '004396' , '002582' , '002583' , '002589' 
		, '002308' , '002592' , '005565' , '002595' , '008965' , '010493' , '005446' , '002601' , '002602' , '004300' , '002604' 
		, '002606' , '002605' , '010141' , '007947' , '002610' , '009030' , '002615' , '005121' , '002617' , '002619' , '009029' 
		, '002625' , '002626' , '002306' , '002627' , '010708' , '010709' , '002632' , '002616' , '002651' , '003529' , '003530' 
		, '003692' , '003700' , '003697' , '003701' , '003702' , '002633' , '002637' , '002640' , '002642' , '002645' , '002646' 
		, '009674' , '002648' , '004397' , '003768' , '002649' , '002652' , '002654' , '010732' , '009355' , '009359' , '009360'
		, '007207' , '002656' , '002657' , '002659' , '002660' , '008123' , '008122' , '006727' , '002666' , '002667' , '002668' 
		, '009677' , '006615' 
		))
order by PM.pmloadid



Select PM2.MovementDate
            ,PM2.WeekOfDate
            ,PM2.PMLoadID
            ,SUM(PM2.Rate) Rate
            ,MAX(PM2.Miles) Miles
            ,SUM(PM2.Fuel) FuelSurcharge
            ,SUM(PM2.EstimatedQty) EstimatedQty
            ,SUM(PM2.ActualQty) ActualQty
            ,PM2.Category
            
from #loads PM2
group by 
 PM2.MovementDate
            ,PM2.WeekOfDate
            ,PMLoadID
            ,Category
            
order by PM2.PMLoadID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_Load_Miles] TO [db_sp_exec]
    AS [dbo];


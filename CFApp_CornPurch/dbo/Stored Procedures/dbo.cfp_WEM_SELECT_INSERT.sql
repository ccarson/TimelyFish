




-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 08/19/2008
-- Description:	
-- Maintenance:     2012/09/21 sripley.  Split out the join of the WEM data and the cornpurch table on the generated insert.
--  instead delete the data from the temptable after the WEM insert.
-- 20141001 - temp change to gross and net weight to handle bad data, roll back after WEM upgrade
-- 20141105 - wem passing nulls for corn producer... setting isnull to unknown
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_WEM_SELECT_INSERT]
(
	@FeedMillID  char(10)
,	@TicketCount int OUTPUT
)
AS
BEGIN
create table #temp_CORN_TICKET
(    [TicketNumber] [varchar] (20)
	,[FeedMillID] [varchar](10) 
	,[CornProducerID] [varchar] (15)
	,[DeliveryDate] [datetime] 
	,[SourceFarm] [varchar] (20)
	,[SourceFarmBin] [varchar] (20) 
	,[DestinationFarmBin] [varchar] (20) 
	,[Status] [varchar] (20) 
	,[PaymentTypeID] [int] 
	,[Commodity] [varchar] (20) 
	,[Moisture] [decimal](10, 4) 
	,[ForeignMaterial] [decimal](10, 4) 
	,[OilContent] [decimal](10, 4)
	,[TestWeight] [decimal](10, 4) 
	,[Gross] [decimal](11, 4)	-- [Gross] [decimal](10, 4)
	,[Net] [decimal](11, 4)		-- [Net] [decimal](10, 4)
	,[Comments] [varchar] (2000) 
	,[ManuallyEntered] [bit]
	,[SentToDryer] [bit] 	
	,[MoistureRateVersion] [int] 
	,[ForeignMaterialRateVersion] [int] 
	,[OilContentRateVersion] [int] 
	,[TestWeightRateVersion] [int] 
	,[DryingRateVersion] [int] 
	,[HandlingFeeVersion] [int] 
	,[DeferredPaymentVersion] [int] 
	,[CornCheckOffVersion] [int] 
	,[EthanolCheckOffVersion] [int] 
	,[ShrinkVersion] [int] 
	,[TicketReminderNote] [varchar]
	,[CornProducerComments] [varchar]
	,[CreatedBy] varchar(50)
	,[CreatedDateTime] datetime)

DECLARE @mysql NVARCHAR(4000)
declare @wemserver varchar(200)
select @wemserver = WEMServer from cft_FEED_MILL (NOLOCK) WHERE RTRIM(FeedMillID) = RTRIM(@FeedMillID)

SET @mysql = N'insert into #temp_CORN_TICKET 
	(TicketNumber
	,FeedMillID
	,CornProducerID
	,DeliveryDate
	,SourceFarm
	,SourceFarmBin
	,DestinationFarmBin
	,Status
	,PaymentTypeID
	,Commodity
	,Moisture
	,ForeignMaterial
	,OilContent
	,TestWeight
	,Gross
	,Net
	,Comments
	,ManuallyEntered
	,SentToDryer
	,MoistureRateVersion
	,ForeignMaterialRateVersion
	,OilContentRateVersion
	,TestWeightRateVersion
	,DryingRateVersion
	,HandlingFeeVersion
	,DeferredPaymentVersion
	,CornCheckOffVersion
	,EthanolCheckOffVersion
	,ShrinkVersion
	,TicketReminderNote
	,CornProducerComments
	,CreatedBy
	,CreatedDateTime)

SELECT * FROM OPENQUERY(' + @wemserver + ', 
	''SELECT 
	  [Transaction]
	, ' + RTRIM(@FeedMillID) + '
	, LEFT(isnull([Vendor],''''Unknown''''),15)		
	, [Net Taken D/T]
	, NULL
	, NULL
	, [Destination]
	, [Status]
	, [Payment Type ID]
	, [Material]
	, [Moisture]
	, [Foreign Material]
	, [Oil Content]
	, [Sample Weight]
	, CAST([Gross Wt] AS NUMERIC(11,4))
	, CAST([Net Wt] AS NUMERIC(11,4))
	, [Comment]
	, 0
	, 0
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, NULL
	, ''''WEM''''
	, GETDATE() 
	FROM [WEMSQL_IO].dbo.RcvTransaction'') WEM
	WHERE [Transaction] IS NOT NULL'

/*
	, CAST([Gross Wt] AS NUMERIC(10,4))
	, CAST([Net Wt] AS NUMERIC(10,4))
*/
exec sp_executesql @mysql


delete from #temp_CORN_TICKET
where EXISTS (select * from cft_CORN_TICKET WHERE TicketNumber = RTRIM(@FeedMillID) + '-' + RTRIM(#temp_CORN_TICKET.TicketNumber)
    AND RTRIM(FeedMillID) = RTRIM(@FeedMillID))

INSERT INTO dbo.cft_CORN_TICKET 
	(TicketNumber
	,FeedMillID
	,CornProducerID
	,DeliveryDate
	,SourceFarm
	,SourceFarmBin
	,DestinationFarmBin
	,Status
	,PaymentTypeID
	,Commodity
	,CommodityID
	,Moisture
	,ForeignMaterial
	,OilContent
	,TestWeight
	,Gross
	,Net
	,Comments
	,ManuallyEntered
	,SentToDryer
	,MoistureRateVersion
	,ForeignMaterialRateVersion
	,OilContentRateVersion
	,TestWeightRateVersion
	,DryingRateVersion
	,HandlingFeeVersion
	,DeferredPaymentVersion
	,CornCheckOffVersion
	,EthanolCheckOffVersion
	,ShrinkVersion
	,TicketReminderNote
	,CornProducerComments
	,CreatedBy
	,CreatedDateTime)
SELECT RTRIM(CT.FeedMillID) + '-' + RTRIM(CT.TicketNumber)
	,CT.FeedMillID
	,UPPER(CT.CornProducerID)
	,CT.DeliveryDate
	,CT.SourceFarm
	,CT.SourceFarmBin
	,CT.DestinationFarmBin
	,CT.Status
	,CT.PaymentTypeID
	,CT.Commodity
	,C.CommodityID
	,CT.Moisture
	,CT.ForeignMaterial
	,CT.OilContent
	,CT.TestWeight
	,CT.Gross
	,CT.Net
	,CT.Comments
	,CT.ManuallyEntered
	,COALESCE(fm.SentToDryer,0)
	,CT.MoistureRateVersion
	,CT.ForeignMaterialRateVersion
	,CT.OilContentRateVersion
	,CT.TestWeightRateVersion
	,CT.DryingRateVersion
	,CT.HandlingFeeVersion
	,CT.DeferredPaymentVersion
	,CT.CornCheckOffVersion
	,CT.EthanolCheckOffVersion
	,CT.ShrinkVersion
	,CT.TicketReminderNote
	,CT.CornProducerComments
	,CT.CreatedBy
	,CT.CreatedDateTime
FROM #temp_CORN_TICKET CT
LEFT OUTER JOIN dbo.cft_COMMODITY C ON CT.Commodity = C.Name
LEFT OUTER JOIN dbo.cft_FEED_MILL fm (NOLOCK) ON RTRIM(fm.FeedMillID) = RTRIM(CT.FeedMillID)
WHERE CT.DeliveryDate >= '1/07/2009'


SELECT @TicketCount = @@rowcount

DROP TABLE #temp_CORN_TICKET
END







GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_WEM_SELECT_INSERT] TO [db_sp_exec]
    AS [dbo];


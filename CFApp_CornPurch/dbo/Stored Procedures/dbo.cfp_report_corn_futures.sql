
-- =============================================
-- Author:		Steve Ripley
-- Create date: 2012-09-20
-- Description:	Generate Futures basis for the corn app team
-- =============================================
CREATE PROCEDURE [dbo].[cfp_report_corn_futures]
@feedmillname varchar(50), @cornproducer	varchar(30)
, @duedatefrom datetime, @duedateto datetime
, @LOG char(1)='N'

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
-------------------------------------------------------------------------------
-- Standard proc settings
-------------------------------------------------------------------------------
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
-------------------------------------------------------------------------------
-- Declare standard variables
-------------------------------------------------------------------------------
DECLARE @RowCount               INT
DECLARE @StepMsg                VARCHAR(255)
DECLARE @DatabaseName           NVARCHAR(128)
DECLARE @ProcessName            VARCHAR(50)
DECLARE @ProcessStatus          INT
DECLARE @StartDate              DATETIME
DECLARE @EndDate                DATETIME
DECLARE @RecordsProcessed       BIGINT
DECLARE @Comments               VARCHAR(2000)
DECLARE @Error                  INT
DECLARE @Criteria               VARCHAR(2000)


-------------------------------------------------------------------------------
-- Set standard variables
-------------------------------------------------------------------------------
SET @DatabaseName       = db_name()
SET @ProcessName        = 'cfp_report_corn_futures'
SET @ProcessStatus      = 0
SET @StartDate          = GETDATE()
SET @RecordsProcessed   = 0
SET @Comments           = 'Started Successfully'
SET @Error              = 0
SET @Criteria           = 
		'@LOG= ' + CAST(@LOG AS VARCHAR) 
-------------------------------------------------------------------------------
-- Log the start of the procedure
-------------------------------------------------------------------------------
IF @LOG='Y' 
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate,
					   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END

-------------------------------------------------------------------------------
-- Truncate staging table    [$(CFFDB)].dbo.cftweeklysales_stg
-------------------------------------------------------------------------------
SET  @StepMsg = 'truncate the temp table'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg;

IF (OBJECT_ID ('tempdb..#futures_data')) IS NOT NULL
	TRUNCATE TABLE #futures_data
Else
IF (OBJECT_ID ('tempdb..#futures_data')) IS NOT NULL
	DROP TABLE #futures_data
	
create TABLE #futures_data		
(cropyear varchar(9),deliv_month_name varchar(20),DeliveryMonthOrder smallint,futures_norm varchar(1),basis_month varchar(2), bushels float,wgtavg_bsh_pb float
, futures_mm varchar(2), futures_yy varchar(4)
, RFM varchar(2));

SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;
	
-------------------------------------------------------------------------------
-- Load temp table
-------------------------------------------------------------------------------
SET  @StepMsg = 'Load temp table #futures_data'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg

/*
if (@duedatefrom) is NULL
	set @duedatefrom = (select convert(char(10),cast(year(getdate())-1 as varchar)+'/'+cast(month('1900-10-01') as varchar)+'/'+cast(day('1900-10-01') as varchar),101))
if (@duedateto) is NULL
	set @duedateto = dateadd(yy,3,@duedatefrom)
*/	
if @FeedMillname = '--All--' set @FeedMillname = '%'
if @cornproducer = '--All--' set @cornproducer = '%'

insert into #futures_data   
select 		--where futures.futuresbasis is null, refbasis = sum(bushels*pricedbasis)/sum(bushels)
case
	when month(delivery_date_From) >= 10 then cast(year(delivery_date_from) as varchar)+'-'+ cast(year(delivery_date_from)+1 as varchar)
	else cast(year(delivery_date_from)-1 as varchar)+'-'+ cast(year(delivery_date_from) as varchar)
end as cropyearname
,datename(MONTH,Delivery_date_from) delivery_month, dm.DeliveryMonthOrder
, dm.normal
,basismon
, SUM(bushels) Bushels
, sum(bushels*PricedBasis)/SUM(bushels) as 'wgtavg_bsh_pb'		-- weighted average  
, reffutmon, basisYear
, basismon as RFM
from 
(SELECT c.ContactName, ct.ContractNumber, cct.name,CONVERT(char(10), ct.DateEstablished, 101) DateEstablished
	, case
		when ct.parent_contrib is null and sum_child_bushels is null then bushels
		when ct.parent_contrib < 0 then bushels
	  end as bushels
	, CONVERT(char(10), ct.DueDateFrom, 101) Delivery_date_from
	, CONVERT(char(10), ct.DueDateTo, 101) Delivery_date_to
	, ct.Cash as purchase_price
	, ct.PricedBasis
	, ct.BasisMonth
	, case when ct.BasisMonth = 1 then 'CH'
		when ct.BasisMonth =2 then 'CK'
		when ct.BasisMonth =3 then 'CN'
		when ct.BasisMonth =4 then 'CU'
		when ct.BasisMonth =5 then 'CZ'
	else 'xx'
	end as basismon
	, ct.BasisYear, ct.FuturesBasis
	, ct.FuturesMonth
	, case when FuturesMonth = 1 then 'CH'
		when FuturesMonth =2 then 'CK'
		when FuturesMonth =3 then 'CN'
		when FuturesMonth =4 then 'CU'
		when FuturesMonth =5 then 'CZ'
	else 'xx'
	end as reffutmon
	, ct.FuturesYear, ct.Futures
	FROM [dbo].[cft_CORN_PRODUCER] crn (nolock)
	join [$(CFApp_Contact)].dbo.cft_CONTACT c (nolock)
		on c.ContactID = crn.ContactID
	join 
		(select parent.cornproducerid, parent.contractnumber, parent.dateestablished, parent.duedatefrom, parent.duedateto, parent.cash, parent.pricedbasis, parent.basismonth
		, basisyear, futuresmonth, futuresyear, parent.bushels bushels, child.bushels Sum_child_bushels, parent.bushels - child.bushels as parent_contrib
		, contracttypeid, feedmillid, contractstatusid, futuresbasis, futures  
		from
		  (select *
		   from dbo.cft_contract (nolock)
		   where contractstatusid in (1,2)) parent
		   left join
		   (SELECT rtrim(feedmillid) + '-' + cast(sequencenumber as varchar)+'%' contract,SUM(Bushels) bushels
		    FROM dbo.cft_CONTRACT (nolock)        
		    WHERE SubsequenceNumber IS NOT NULL 
			  AND ContractStatusID IN (1, 2)
		    group by rtrim(feedmillid) + '-' + cast(sequencenumber as varchar)) as child
				on parent.contractnumber like child.contract
				and len(parent.contractnumber) - len(child.contract) <= 1
				and substring(reverse(parent.contractnumber),1,1) = substring(reverse(child.contract),2,1) ) ct
		on ct.CornProducerID = crn.CornProducerID
	join dbo.cft_CONTRACT_TYPE cct (nolock)
		on cct.ContractTypeID = ct.ContractTypeID
	join dbo.cft_FEED_MILL fm (nolock)
		on fm.feedmillid = ct.feedmillid
	where fm.name like @feedmillname	
	  and ct.contracttypeid in (3,4,21,30,47)	--deferred payment contract, fixed basis contract, standard case contract, ia fixed basis contract, ia standard cash contract
	  and ct.contractstatusid in ('1','2')  -- open or closed, no void
	  and (ct.sum_child_bushels is null or ct.bushels <> ct.sum_child_bushels)
	  and c.ContactName	like @cornproducer		
	  and ct.duedatefrom between @duedatefrom and @duedateto
	) as futures
left join 
(
              SELECT 10 AS DeliveryMonth, datename(month, '10/01/2008') AS DeliveryMonthName, 1 AS DeliveryMonthOrder, 'Z' as Normal
              UNION SELECT 11 AS DeliveryMonth, datename(month, '11/01/2008') AS DeliveryMonthName, 2 AS DeliveryMonthOrder, 'Z' as Normal
              UNION SELECT 12 AS DeliveryMonth, datename(month, '12/01/2008') AS DeliveryMonthName, 3 AS DeliveryMonthOrder, 'H' as Normal
              UNION SELECT 1 AS DeliveryMonth, datename(month, '01/01/2008') AS DeliveryMonthName, 4 AS DeliveryMonthOrder, 'H' as Normal
              UNION SELECT 2 AS DeliveryMonth, datename(month, '02/01/2008') AS DeliveryMonthName, 5 AS DeliveryMonthOrder, 'H' as Normal
              UNION SELECT 3 AS DeliveryMonth, datename(month, '03/01/2008') AS DeliveryMonthName, 6 AS DeliveryMonthOrder, 'K' as Normal
              UNION SELECT 4 AS DeliveryMonth, datename(month, '04/01/2008') AS DeliveryMonthName, 7 AS DeliveryMonthOrder, 'K' as Normal
              UNION SELECT 5 AS DeliveryMonth, datename(month, '05/01/2008') AS DeliveryMonthName, 8 AS DeliveryMonthOrder, 'N' as Normal
              UNION SELECT 6 AS DeliveryMonth, datename(month, '06/01/2008') AS DeliveryMonthName, 9 AS DeliveryMonthOrder, 'N' as Normal
              UNION SELECT 7 AS DeliveryMonth, datename(month, '07/01/2008') AS DeliveryMonthName, 10 AS DeliveryMonthOrder, 'U' as Normal
              UNION SELECT 8 AS DeliveryMonth, datename(month, '08/01/2008') AS DeliveryMonthName, 11 AS DeliveryMonthOrder, 'U' as Normal
              UNION SELECT 9 AS DeliveryMonth, datename(month, '09/01/2008') AS DeliveryMonthName, 12 AS DeliveryMonthOrder, 'Z' as Normal
           )  as DM		--Table of delivery months futures fDM
	on dm.deliverymonth = month(futures.delivery_date_from)
where futures.futuresbasis is null
group by case
	when month(delivery_date_From) >= 10 then cast(year(delivery_date_from) as varchar)+'-'+ cast(year(delivery_date_from)+1 as varchar)
	else cast(year(delivery_date_from)-1 as varchar)+'-'+ cast(year(delivery_date_from) as varchar)
end 
,datename(MONTH,futures.Delivery_date_from)
,basismon
,dm.normal,reffutmon, futures.BasisYear, dm.DeliveryMonthOrder

union

select 	--where futures.futuresbasis is not null, refbasis = sum(bushels*futurebasis)/sum(bushels)
case
	when month(delivery_date_From) >= 10 then cast(year(delivery_date_from) as varchar)+'-'+ cast(year(delivery_date_from)+1 as varchar)
	else cast(year(delivery_date_from)-1 as varchar)+'-'+ cast(year(delivery_date_from) as varchar)
end as cropyearname
,datename(MONTH,Delivery_date_from) delivery_month, dm.DeliveryMonthOrder
, dm.normal
,basismon
, SUM(bushels) Bushels
, sum(bushels*FuturesBasis)/SUM(bushels) as 'wgtavg_bsh_pb'		-- weighted average
, reffutmon, futuresYear
, reffutmon as RFM
from 
(SELECT c.ContactName, ct.ContractNumber, cct.name,CONVERT(char(10), ct.DateEstablished, 101) DateEstablished
	, case
		when ct.parent_contrib is null and sum_child_bushels is null then bushels
		when ct.parent_contrib < 0 then bushels
	  end as bushels
	, CONVERT(char(10), ct.DueDateFrom, 101) Delivery_date_from
	, CONVERT(char(10), ct.DueDateTo, 101) Delivery_date_to
	, ct.Cash as purchase_price
	, ct.PricedBasis
	, ct.BasisMonth
	, case when ct.BasisMonth = 1 then 'CH'
		when ct.BasisMonth =2 then 'CK'
		when ct.BasisMonth =3 then 'CN'
		when ct.BasisMonth =4 then 'CU'
		when ct.BasisMonth =5 then 'CZ'
	else 'xx'
	end as basismon
	, ct.BasisYear, ct.FuturesBasis
	, ct.FuturesMonth
	, case when FuturesMonth = 1 then 'CH'
		when FuturesMonth =2 then 'CK'
		when FuturesMonth =3 then 'CN'
		when FuturesMonth =4 then 'CU'
		when FuturesMonth =5 then 'CZ'
	else 'xx'
	end as reffutmon
	, ct.FuturesYear, ct.Futures
	FROM [dbo].[cft_CORN_PRODUCER] crn (nolock)
	join [$(CFApp_Contact)].dbo.cft_CONTACT c (nolock)
		on c.ContactID = crn.ContactID
	join 
		(select parent.cornproducerid, parent.contractnumber, parent.dateestablished, parent.duedatefrom, parent.duedateto, parent.cash, parent.pricedbasis, parent.basismonth
		, basisyear, futuresmonth, futuresyear, parent.bushels bushels, child.bushels Sum_child_bushels, parent.bushels - child.bushels as parent_contrib
		, contracttypeid, feedmillid, contractstatusid, futuresbasis, futures  
		from
		  (select *
		   from dbo.cft_contract (nolock)
		   where contractstatusid in (1,2)) parent
		   left join
		   (SELECT rtrim(feedmillid) + '-' + cast(sequencenumber as varchar)+'%' contract,SUM(Bushels) bushels
		    FROM dbo.cft_CONTRACT (nolock)        
		    WHERE SubsequenceNumber IS NOT NULL 
			  AND ContractStatusID IN (1, 2)
		    group by rtrim(feedmillid) + '-' + cast(sequencenumber as varchar)) as child
				on parent.contractnumber like child.contract) ct 
		on ct.CornProducerID = crn.CornProducerID
	join dbo.cft_CONTRACT_TYPE cct (nolock)
		on cct.ContractTypeID = ct.ContractTypeID
	join dbo.cft_FEED_MILL fm (nolock)
		on fm.feedmillid = ct.feedmillid
	where fm.name like @feedmillname	
	  and ct.contracttypeid in (3,4,21,30,47)	--deferred payment contract, fixed basis contract, standard case contract, ia fixed basis contract, ia standard cash contract
	  and ct.contractstatusid in ('1','2')  -- open or closed, no void
	  and (ct.sum_child_bushels is null or ct.bushels <> ct.sum_child_bushels)
	  and c.ContactName	like @cornproducer		
	  and ct.duedatefrom between @duedatefrom and @duedateto
	) as futures
left join 
(
              SELECT 10 AS DeliveryMonth, datename(month, '10/01/2008') AS DeliveryMonthName, 1 AS DeliveryMonthOrder, 'Z' as Normal
              UNION SELECT 11 AS DeliveryMonth, datename(month, '11/01/2008') AS DeliveryMonthName, 2 AS DeliveryMonthOrder, 'Z' as Normal
              UNION SELECT 12 AS DeliveryMonth, datename(month, '12/01/2008') AS DeliveryMonthName, 3 AS DeliveryMonthOrder, 'H' as Normal
              UNION SELECT 1 AS DeliveryMonth, datename(month, '01/01/2008') AS DeliveryMonthName, 4 AS DeliveryMonthOrder, 'H' as Normal
              UNION SELECT 2 AS DeliveryMonth, datename(month, '02/01/2008') AS DeliveryMonthName, 5 AS DeliveryMonthOrder, 'H' as Normal
              UNION SELECT 3 AS DeliveryMonth, datename(month, '03/01/2008') AS DeliveryMonthName, 6 AS DeliveryMonthOrder, 'K' as Normal
              UNION SELECT 4 AS DeliveryMonth, datename(month, '04/01/2008') AS DeliveryMonthName, 7 AS DeliveryMonthOrder, 'K' as Normal
              UNION SELECT 5 AS DeliveryMonth, datename(month, '05/01/2008') AS DeliveryMonthName, 8 AS DeliveryMonthOrder, 'N' as Normal
              UNION SELECT 6 AS DeliveryMonth, datename(month, '06/01/2008') AS DeliveryMonthName, 9 AS DeliveryMonthOrder, 'N' as Normal
              UNION SELECT 7 AS DeliveryMonth, datename(month, '07/01/2008') AS DeliveryMonthName, 10 AS DeliveryMonthOrder, 'U' as Normal
              UNION SELECT 8 AS DeliveryMonth, datename(month, '08/01/2008') AS DeliveryMonthName, 11 AS DeliveryMonthOrder, 'U' as Normal
              UNION SELECT 9 AS DeliveryMonth, datename(month, '09/01/2008') AS DeliveryMonthName, 12 AS DeliveryMonthOrder, 'Z' as Normal
           )  as DM		--Table of delivery months futures fDM
	on dm.deliverymonth = month(futures.delivery_date_from)
where futures.futuresbasis is not null
group by case
	when month(delivery_date_From) >= 10 then cast(year(delivery_date_from) as varchar)+'-'+ cast(year(delivery_date_from)+1 as varchar)
	else cast(year(delivery_date_from)-1 as varchar)+'-'+ cast(year(delivery_date_from) as varchar)
end
,datename(MONTH,futures.Delivery_date_from)
,reffutmon
,dm.normal,futures.basismon, futures.futuresYear, dm.DeliveryMonthOrder


SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;


SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
 IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg




create TABLE #futures_data_sum		
(cropyear varchar(9),deliv_month_name varchar(20),DeliveryMonthOrder smallint
,futures_norm varchar(1),basis_month varchar(2)
, bushels float,wgtavg_bsh_pb float
, futures_mm varchar(2), futures_yy varchar(4)
, RFM varchar(2));



insert into #futures_data_sum
select cropyear, deliv_month_name,deliverymonthorder, max(futures_norm), max(basis_month),
sum(bushels), sum(bushels*wgtavg_bsh_pb)/sum(bushels), futures_mm, futures_yy, RFM
from #futures_data
group by cropyear, RFM, futures_mm, futures_yy, deliv_month_name,deliverymonthorder
order by futures_yy, RFM, cropyear, deliverymonthorder



select cropyear, deliv_month_name  delivery_month, futures_norm Normal, bushels, RFM, futures_yy , wgtavg_bsh_pb refbasis, deliverymonthorder
, case 
	when futures_norm = right(rfm,1) then wgtavg_bsh_pb - (fv.value-fv.value)
	else wgtavg_bsh_pb - (fv.value-fv2.value)
end as normbasis
from #futures_data_sum 
left join dbo.cft_futures_values fv (nolock)	-- normalized basis  = weightedaverage - (fv - prior fv) when norm = referencedBasis
	on fv.month = futures_mm and fv.year = futures_yy
left join dbo.cft_futures_values fv2 (nolock)	-- prior fv
	on fv2.month = basis_month and fv2.year=futures_yy	


END


TheEnd:
SET @EndDate = GETDATE()
IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
EXEC [$(CFFDB)].dbo.cfp_PrintTs 'End'
RAISERROR (@Comments, @ProcessStatus, 1)

RETURN @ProcessStatus

-------------------------------------------------------------------------------
-- Error handling
-------------------------------------------------------------------------------
ERR_Common:
    SET @Comments         = 'Error in step: ' + @StepMsg

    SET @ProcessStatus    = 16
    SET @RecordsProcessed = 0
    GOTO TheEnd					













GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_report_corn_futures] TO [SE\ssis_datawriter]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_report_corn_futures] TO [SSIS_CornPurch]
    AS [dbo];


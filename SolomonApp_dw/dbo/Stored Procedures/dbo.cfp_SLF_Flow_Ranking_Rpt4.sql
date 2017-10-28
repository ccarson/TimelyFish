






CREATE PROCEDURE [dbo].[cfp_SLF_Flow_Ranking_Rpt4]
					@LOG char(1)='N'
AS
BEGIN
/*
===============================================================================
Purpose: 

Inputs:
Outputs:    
Returns:    0 for success, 1 for failure
Enviroment:    Test, Production 

DEBUG:

exec [$(CFFDB)].dbo.cfp_PrintTs  'start 1'
exec 
exec [$(CFFDB)].dbo.cfp_PrintTs 'end 1'

Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2014-12-01  S Ripley	SLF report # 4  Ranking of Flows for each picyear_week

===============================================================================
*/

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
SET @ProcessName        = 'cfp_SLF_Flow_Ranking_Rpt4'
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
-- Insert daily info
-------------------------------------------------------------------------------
SET  @StepMsg = 'Insert/Update Weekly info'
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg


-- create a temp table for the 5 executed stored procedures.
set @StepMsg = 'create #ADG';

CREATE table #ADG (
    [picyearweek] varchar(6) null,
	[rptgrpid] int NULL,
	[Reporting_Group_Description] [varchar](100) NULL,
	[Avg Wean Age] [float] NULL,
	[Avg Wean Wgt] [float] NULL,
	[ADG FH] [float] NULL,
	[ADG Nursery] [float] NULL,
	[ADG Finish] [float] NULL,
	[ADG WTF] [float] NULL,
	[ADG rollup] [float] NULL
	)

   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
   
set @StepMsg = 'create #cost';
CREATE table #cost (
    [picyearweek] varchar(6) null,
	[rptgrpid] int NULL,
	[Reporting_Group_Description] [varchar](100) NULL,
	[WP_CostPerPig] [float] NULL,
	[FP_CostPerPig] [float] NULL,
	[Feed_Cost_of_Gain] [float] NULL,
	[TotCost_of_gain_per_cwt] [float] NULL,
	[revenue_per_cwt] [float] NULL,
	[margin_per_cwt] [float] NULL,
	[Med_per_HS] [float] NULL,
	[Vacc_per_HS] [float] NULL,
	[TotCost_per_cwt] [float] NULL
)
   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
   
set @StepMsg = 'create #fe';
CREATE table #fe (
    [picyearweek] varchar(6) null,
	[rptgrpid] int NULL,
	[Reporting_Group_Description] [varchar](100) NULL,
	[Lac_lbs_day] [float] NULL,
	[Lac_days] [float] NULL,
	[Lac_lbs_sow_year] [float] NULL,
	[Gest_lbs_day] [float] NULL,
	[Gest_days] [float] NULL,
	[Gest_lbs_sow_year] [float] NULL,
	[Tot_tonsowyear] [float] NULL,
	[NurFE] [float] NULL,
	[FinFE] [float] NULL,
	[WTFFE] [float] NULL,
	[WholeHerdFE] [float] NULL
)

   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
   
set @StepMsg = 'create #mkt';
CREATE table #mkt (
    [picyearweek] varchar(6) null,
	[rptgrpid] int NULL,
	[Reporting_Group_Description] [varchar](100) NULL,
	[PctPrim] [float] NULL,
	[PctReSale] [float] NULL,
	[PctCull] [float] NULL,
	[Avg_Mkt_Wgt] [float] NULL,
	[PigMkt_sowperyear] [float] NULL,
	[LBS_invsowperyear] [float] NULL

)

   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
   

set @StepMsg = 'create #mort';
CREATE table #mort (
    [picyearweek] varchar(6) null,
	[rptgrpid] int NULL,
	[Reporting_Group_Description] [varchar](100) NULL,
	[Avg_born] [float] NULL,
	[Avg_BornAlive] [float] NULL,
	[Wean/Litter] [float] NULL,
	[PctMummy] [float] NULL,
	[PctStillBorn] [float] NULL,
	[PctFarHouse] [float] NULL,
	[NurDOTpct] [float] NULL,
	[NurMortpct] [float] NULL,
	[FinDOTpct] [float] NULL,
	[FinMortpct] [float] NULL,
	[WTFDOTpct] [float] NULL,
	[WTFMortpct] [float] NULL,
	[DOTpct] [float] NULL,
	[DIYpct] [float] NULL,
	[Compct] [float] NULL,
	[TotPctMort] [float] NULL
	)

   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
   

delete 
from [dbo].[cft_SLF_Flow_Ranking_Rpt4] 
where picyearweek >=
(select min(picyear_week) picyear_week
from [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo] dd (nolock)
where daydate = cast(getdate() - 28 as date))

   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
   

select picyear_week, row_number() over(order by picyear_week) as rownbr
into #picweek
from [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo] dd (nolock)
where daydate between cast(getdate() - 35 as date) and cast(getdate() as date)
and dayname = 'sunday'
order by picyear_week

   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
   

   
DECLARE @NumberRecords int, @rcnt int, @pg_week char(6), @picyear_week char(6)

select @NumberRecords = count(1) from #picweek

   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

SET @rcnt = 1


-- loop through all records in the temporary table
-- using the WHILE loop construct
WHILE @rcnt <= @NumberRecords
BEGIN

 SELECT @picyear_week = picyear_week from #picweek
 WHERE Rownbr = @rcnt
 
 select @picyear_week as picyear_week, @rcnt as rcnt

		set @StepMsg = 'insert into #adg';
		INSERT INTO #ADG
		EXEC	[dbo].[cfp_REPORT_SLF_FLOW_KPI_ADG_all]
				@pg_week = @picyear_week

		   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
				
		set @StepMsg = 'insert into #cost';
		INSERT INTO #cost
		EXEC	[dbo].[cfp_REPORT_SLF_FLOW_KPI_costs_all]
				@pg_week = @picyear_week
				
		   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

		set @StepMsg = 'insert into #fe';
		INSERT INTO #fe
		EXEC	[dbo].[cfp_REPORT_SLF_FLOW_KPI_fe_all]
				@pg_week = @picyear_week
				
		   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

		set @StepMsg = 'insert into mkt';
		INSERT INTO #mkt
		EXEC	[dbo].[cfp_REPORT_SLF_FLOW_KPI_mkting_all]
				@pg_week = @picyear_week

		   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
		   
		set @StepMsg = 'insert into #mort';
		INSERT INTO #mort
		EXEC	[dbo].[cfp_REPORT_SLF_FLOW_KPI_mort_all]
				@pg_week = @picyear_week

		   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

		-- add data to the reporting table

		set @StepMsg = 'insert #adg into cft_SLF_Flow_Ranking_Rpt4';

		insert into  dbo.cft_SLF_Flow_Ranking_Rpt4
		(picyearweek,ReportingGroupID,[Reporting_Group_Description],
			[Avg Wean Age],
			[Avg Wean Wgt] ,
			[ADG FH] ,
			[ADG Nursery],
			[ADG Finish],
			[ADG WTF] ,
			[ADG rollup] )
		select picyearweek,rptgrpid,[Reporting_Group_Description],
			[Avg Wean Age],
			[Avg Wean Wgt] ,
			[ADG FH] ,
			[ADG Nursery],
			[ADG Finish],
			[ADG WTF] ,
			[ADG rollup] from #adg
		where rptgrpid <> 0
			
		   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
			
		set @StepMsg = 'update cft_SLF_Flow_Ranking_Rpt4 from #cost';
			
		update  dbo.cft_SLF_Flow_Ranking_Rpt4
		set [WP_CostPerPig] = #cost.[WP_CostPerPig]
			,[FP_CostPerPig] = #cost.[FP_CostPerPig]
			,[Feed_Cost_of_Gain] = #cost.[Feed_Cost_of_Gain]
			,[TotCost_of_gain_per_cwt] = #cost.[TotCost_of_gain_per_cwt]
			,[revenue_per_cwt] = #cost.[revenue_per_cwt]
			,[margin_per_cwt] = #cost.[margin_per_cwt]
			,[Med_per_HS]  = #cost.[Med_per_HS]
			,[Vacc_per_HS] = #cost.[Vacc_per_HS] 
			,[TotCost_per_cwt] = #cost.[TotCost_per_cwt] 
		from  dbo.cft_SLF_Flow_Ranking_Rpt4 t 
		join #cost
			on #cost.picyearweek = t.picyearweek and #cost.rptgrpid = t.reportinggroupid
		where t.reportinggroupid <> 0
			
		   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
		   
		   
		set @StepMsg = 'update cft_SLF_Flow_Ranking_Rpt4 from #fe';
			
		update  dbo.cft_SLF_Flow_Ranking_Rpt4
		set [Lac_lbs_day] = #fe.[Lac_lbs_day]
			,[Lac_days] = #fe.[Lac_days]
			,[Lac_lbs_sow_year] = #fe.[Lac_lbs_sow_year]
			,[Gest_lbs_day] = #fe.[Gest_lbs_day]
			,[Gest_days] = #fe.[Gest_days]
			,[Gest_lbs_sow_year] = #fe.[Gest_lbs_sow_year]
			,[Tot_tonsowyear]  = #fe.[Tot_tonsowyear]
			,[NurFE] = #fe.[NurFE] 
			,[FinFE] = #fe.[FinFE] 
			,[WTFFE] = #fe.[WTFFE]
			,[WholeHerdFE] = #fe.[WholeHerdFE] 
		from  dbo.cft_SLF_Flow_Ranking_Rpt4 t 
		join #fe
			on #fe.picyearweek = t.picyearweek and #fe.rptgrpid = t.reportinggroupid
		where t.reportinggroupid <> 0

		   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

		set @StepMsg = 'update cft_SLF_Flow_Ranking_Rpt4 from #mkt';

		update  dbo.cft_SLF_Flow_Ranking_Rpt4
		set [PctPrim] = #mkt.[PctPrim]
			,[PctReSale] = #mkt.[PctReSale]
			,[PctCull] = #mkt.[PctCull]
			,[Avg_Mkt_Wgt] = #mkt.[Avg_Mkt_Wgt]
			,[PigMkt_sowperyear] = #mkt.[PigMkt_sowperyear]
			,[LBS_invsowperyear] = #mkt.[LBS_invsowperyear]
		from  dbo.cft_SLF_Flow_Ranking_Rpt4 t 
		join #mkt
			on #mkt.picyearweek = t.picyearweek and #mkt.rptgrpid = t.reportinggroupid
		where t.reportinggroupid <> 0
			
		   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
		   
		set @StepMsg = 'update cft_SLF_Flow_Ranking_Rpt4 from #mort';

		update  dbo.cft_SLF_Flow_Ranking_Rpt4
		set [Avg_born] = #mort.[Avg_born]
			,[Avg_BornAlive] = #mort.[Avg_BornAlive]
			,[Wean/Litter] = #mort.[Wean/Litter]
			,[PctMummy] = #mort.[PctMummy]
			,[PctStillBorn] = #mort.[PctStillBorn]
			,[PctFarHouse] = #mort.[PctFarHouse]
			,[NurDOTpct] = #mort.[NurDOTpct]
			,[NurMortpct] = #mort.[NurMortpct]
			,[FinDOTpct] = #mort.[FinDOTpct]
			,[FinMortpct] = #mort.[FinMortpct]
			,[WTFDOTpct] = #mort.[WTFDOTpct]
			,[WTFMortpct] = #mort.[WTFMortpct]
			,[DOTpct] = #mort.[DOTpct]
			,[DIYpct] = #mort.[DIYpct]
			,[Compct] = #mort.[Compct]
			,[TotPctMort] = #mort.[TotPctMort]
		from  dbo.cft_SLF_Flow_Ranking_Rpt4 t 
		join #mort
			on #mort.picyearweek = t.picyearweek and #mort.rptgrpid = t.reportinggroupid
		where t.reportinggroupid <> 0
			
		   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
		   	
			---after all the weekly loads.
			
		set @StepMsg = 'update cft_SLF_Flow_Ranking_Rpt4 adgrank';

		update  dbo.cft_SLF_Flow_Ranking_Rpt4
		set adg_rank = k.ADGRank
		from  dbo.cft_SLF_Flow_Ranking_Rpt4 r
		join (select picyearweek, reportinggroupid, reporting_group_description
		, [Adg rollup] 
		,Rank() over (Partition by picyearweek Order by [Adg rollup] desc) as 'ADGRank'
		from  dbo.cft_SLF_Flow_Ranking_Rpt4) k
			on k.picyearweek = r.picyearweek and k.reportinggroupid = r.reportinggroupid
		where r.reportinggroupid <> 0
		and r.[Adg rollup] is not null

		   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common

		set @StepMsg = 'update cft_SLF_Flow_Ranking_Rpt4 costrank';

		update  dbo.cft_SLF_Flow_Ranking_Rpt4
		set cost_rank = k.costRank
		from  dbo.cft_SLF_Flow_Ranking_Rpt4 r
		join (select picyearweek, reportinggroupid, reporting_group_description
		, totcost_per_cwt 
		,Rank() over (Partition by picyearweek Order by [totcost_per_cwt] ) as 'costRank'
		from  dbo.cft_SLF_Flow_Ranking_Rpt4
		where totcost_per_cwt is not null ) k
			on k.picyearweek = r.picyearweek and k.reportinggroupid = r.reportinggroupid
		where r.reportinggroupid <> 0
		and r.[totcost_per_cwt] is not null
			
		   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
		   
		set @StepMsg = 'update cft_SLF_Flow_Ranking_Rpt4 FErank';

		update  dbo.cft_SLF_Flow_Ranking_Rpt4
		set fe_rank = k.FERank
		from  dbo.cft_SLF_Flow_Ranking_Rpt4 r
		join (select picyearweek, reportinggroupid, reporting_group_description
		, wholeherdfe 
		,Rank() over (Partition by picyearweek Order by wholeherdfe ) as 'FERank'
		from  dbo.cft_SLF_Flow_Ranking_Rpt4
		where wholeherdfe is not null ) k
			on k.picyearweek = r.picyearweek and k.reportinggroupid = r.reportinggroupid
		where r.reportinggroupid <> 0
		and r.[wholeherdfe] is not null
			
		   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
		   
		set @StepMsg = 'update cft_SLF_Flow_Ranking_Rpt4 lbsrank';

		update  dbo.cft_SLF_Flow_Ranking_Rpt4
		set lbs_sowperyear_rank = k.lbsRank
		from  dbo.cft_SLF_Flow_Ranking_Rpt4 r
		join (select picyearweek, reportinggroupid, reporting_group_description
		, lbs_invsowperyear 
		,Rank() over (Partition by picyearweek Order by lbs_invsowperyear desc ) as 'lbsRank'
		from  dbo.cft_SLF_Flow_Ranking_Rpt4
		where lbs_invsowperyear is not null ) k
			on k.picyearweek = r.picyearweek and k.reportinggroupid = r.reportinggroupid
		where r.reportinggroupid <> 0
		and r.[lbs_invsowperyear] is not null

		   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
		   	
		set @StepMsg = 'update cft_SLF_Flow_Ranking_Rpt4 mortrank';
			
		update  dbo.cft_SLF_Flow_Ranking_Rpt4
		set mort_rank = k.mortrank
		from  dbo.cft_SLF_Flow_Ranking_Rpt4 r
		join (select picyearweek, reportinggroupid, reporting_group_description
		, totpctmort 
		,Rank() over (Partition by picyearweek Order by totpctmort ) as 'mortRank'
		from  dbo.cft_SLF_Flow_Ranking_Rpt4
		where totpctmort is not null ) k
			on k.picyearweek = r.picyearweek and k.reportinggroupid = r.reportinggroupid
		where r.reportinggroupid <> 0
		and r.[totpctmort] is not null

		   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
		   
		set @StepMsg = 'update cft_SLF_Flow_Ranking_Rpt4 totalrank';	
			
		update  dbo.cft_SLF_Flow_Ranking_Rpt4
		set total_rank = k.totrank
		from  dbo.cft_SLF_Flow_Ranking_Rpt4 r
		join (select picyearweek, reportinggroupid, reporting_group_description 
		, ( (isnull(adg_rank,999)*0.2)+(isnull(cost_rank,999)*0.2) + (isnull(fe_rank,999)*0.2) + (isnull(lbs_sowperyear_rank,999)*0.2) + (isnull(mort_rank,999)*0.2) ) Trank  
		,Rank() over (Partition by picyearweek Order by ( (isnull(adg_rank,999)*0.2)+(isnull(cost_rank,999)*0.2) + (isnull(fe_rank,999)*0.2) + (isnull(lbs_sowperyear_rank,999)*0.2) + (isnull(mort_rank,999)*0.2) ) ) as 'totRank'
		from  dbo.cft_SLF_Flow_Ranking_Rpt4 ) k
			on k.picyearweek = r.picyearweek and k.reportinggroupid = r.reportinggroupid
		where r.reportinggroupid <> 0
		and r.adg_rank is not null
		and r.cost_rank is not null
		and r.fe_rank is not null
		and r.lbs_sowperyear_rank is not null
		and r.mort_rank is not null



		   SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
		   
		   
	delete from #adg
	SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
	delete from #fe
	SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
	delete from #mort
	SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
	delete from #cost
	SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
	delete from #mkt
	SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common
		   
 SET @rcnt = @Rcnt + 1
 end
 
END
-------------------------------------------------------------------------------
-- If the procedure gets to here, it is a successful run
-- NOTE: Make sure to capture @RecordsProcessed from your main query
-------------------------------------------------------------------------------
SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully, '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'

-------------------------------------------------------------------------------
-- Log the end of the procedure
-------------------------------------------------------------------------------
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

	  













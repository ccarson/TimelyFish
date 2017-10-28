






CREATE PROCEDURE [dbo].[cfp_cube_ASOLivG_priorcumclosed_eb]
					@LOG char(1)='Y'
AS
BEGIN
/*
===============================================================================
Purpose: Prepare data for loading into a cube

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
2015-01-20	sripley		new proc to append data to ASOLivG staging table CumClosed

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
declare @blddate				DATETIME		-- week to start deleting data
declare @startweek				varchar(6)		-- week to start deleting data


-------------------------------------------------------------------------------
-- Set standard variables
-------------------------------------------------------------------------------
SET @DatabaseName       = db_name()
SET @ProcessName        = 'cfp_cube_ASOLivG_priorcumclosed_eb'
SET @ProcessStatus      = 0
SET @StartDate          = GETDATE()
SET @RecordsProcessed   = 0
SET @Comments           = 'Started Successfully'
SET @Error              = 0
SET @Criteria           = '@LOG= ' + CAST(@LOG AS VARCHAR) 
-------------------------------------------------------------------------------
-- Log the start of the procedure
-------------------------------------------------------------------------------
IF @LOG='Y' 
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate,
					   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
--#####################################################################################################################
-- Delete rows from table:  prior x weeks
--#####################################################################################################################
select @startweek = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = cast(DATEADD(ww,-52,getdate()) as date)

select @blddate=min(daydate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where picyear_week  = @startweek

Delete from  [dbo].[cft_ASOLivG_priorcumclosed]
where time >= @startweek

--CREATE TABLE [dbo].[cft_ASOLivG_priorcumclosed](
--	[PICweekDesc] [varchar](10) NULL,
--	[PICYearDesc] [varchar](10) NULL,
--	[Time] [varchar](6) NULL,
--	[account] [varchar](30) NULL,
--	[system] [varchar](30) NULL,
--	[pod] [varchar](30) NULL,
--	[Scenario] [varchar](7) NULL,
--	[Group Number] [varchar](12) NULL,
--	[GroupAlias] [varchar](43) NULL,
--	[DetailPhase] [varchar](36) NULL,
--	[WeekOfAge] [varchar](10) NULL,
--	[PhaseWeek] [varchar](6) NULL,
--	[GroupStatus] [varchar](30) NULL,
--	[Qty] [int] NULL
--) ON [PRIMARY]

insert into  [dbo].[cft_ASOLivG_priorcumclosed]
Select
PPig.PICWeekDesc,
PPig.PICYearDesc,
PPig.Time,
PPig.Account,
PPig.System,
PPig.Pod,
PPig.Scenario,
PPig."Group Number",
PPig.GroupAlias,
PPig.DetailPhase,
PPig.WeekOfAge,
PPig.PhaseWeek,
PPig.GroupStatus,
PPig.Qty

From (

select
case when d.FiscalYear='2009' and d.PICWeek='48' then 'PICWK48A'
else 
'PICWK' + Replicate('0',2-LEN(rtrim(d.PICWeek))) +
rtrim(d.PICWeek) end PICWeekDesc,
'PICYR' + Convert(char(4),d.PICYear) PICYearDesc,
d.PICYear_Week Time,
case when IT.acct='PIG SALE' and pm.MarketSaleTypeID='10' then 'PRIOR CUM TOP PIG SALE'
when IT.acct='PIG SALE' and pm.MarketSaleTypeID<>'10' then 'PRIOR CUM CLOSE PIG SALE'
when IT.acct='PIG SALE' and pm.MarketSaleTypeID is null then 'PRIOR CUM CLOSE PIG SALE'
else 'PRIOR CUM '+rtrim(IT.acct)
end Account,
rtrim(PS.Description) System,
rtrim(PP.Description) Pod,
'FY '+convert(char(4),rtrim(d.FiscalYear)) 'Scenario',
'PG'+rtrim(PG.PigGroupID) 'Group Number',
'PG'+rtrim(PG.PigGroupID)+'-'+rtrim(PG.Description) GroupAlias,
case
when PG.SingleStock <> 0
and FT.Description='WF'
and PG.PigProdPhaseID in ('NUR','FIN')
then 'SS WF '
when PG.SingleStock = 0
and FT.Description='WF'
and PG.PigProdPhaseID='NUR'
then 'WF '
else ''
end
+
rtrim(P.PhaseDesc) DetailPhase,
case
----For StartAge=0, not in NUR or WTF, Tran before PigStartDate
when pg.CF10=0
and pg.PigProdPhaseID in ('NUR','WTF')
and datediff(day,d2.WeekOfDate,d.WeekOfDate)<0 then
	'WK03'
----For StartAge=0, in NUR or WTF, and WeekOfAge >= 41 weeks
when pg.CF10=0
and pg.PigProdPhaseID in ('NUR','WTF')
and datediff(day,d2.WeekOfDate,d.WeekOfDate)>=0
and round((21 + datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)>=41 then
	'WK41+'
----For StartAge=0, in NUR or WTF, and WeekOfAge < 41 weeks
when pg.CF10=0
and pg.PigProdPhaseID in ('NUR','WTF')
and datediff(day,d2.WeekOfDate,d.WeekOfDate)>=0
and round((21 + datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)<41 then
	'WK' +
	Replicate('0', 2 -
		Len(rtrim(
		Convert(char(2),
			round((21 + datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)
			)))) +
			+ rtrim(Convert(char(2),
			round((21 + datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)
			))
----For StartAge=0, Uses StartWgt for Age, WeekOfAge >= 41 weeks	
when pg.CF10=0
and pg.PigProdPhaseID not in ('NUR','WTF')
and datediff(day,d2.WeekOfDate,d.WeekOfDate)>=0
and round(((50-((50-st.Wgt)/1.1)+21)+ datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)>=41 then
	'WK41+'
----For StartAge=0, Uses StartWgt for Age, WeekOfAge >= 41 weeks	
when pg.CF10=0
and pg.PigProdPhaseID not in ('NUR','WTF')
and datediff(day,d2.WeekOfDate,d.WeekOfDate)<0
and round(((50-((50-st.Wgt)/1.1)+21))/7,0)>=41 then
	'WK41+'		
----For StartAge=0, Uses StartWgt for Age, WeekOfAge < 41 weeks
when pg.CF10=0
and pg.PigProdPhaseID not in ('NUR','WTF')
and datediff(day,d2.WeekOfDate,d.WeekOfDate)>=0
and round(((50-((50-st.Wgt)/1.1)+21)+ datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)<41 then
	'WK' +
	Replicate('0', 2 -
		Len(rtrim(
		Convert(char(2),
			round(((50-((50-st.Wgt)/1.1)+21)+ datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)
			)))) +
			+ rtrim(Convert(char(2),
			round(((50-((50-st.Wgt)/1.1)+21)+ datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)			
			))
----For start age<>0, Tran before PigStartDate
when pg.CF10<>0
and datediff(day,d2.WeekOfDate,d.WeekOfDate)<0 then
	'WK' +
	Replicate('0', 2 -
		Len(rtrim(
		Convert(char(2),
			round((21+pg.CF10)/7,0)
			)))) +
			+ rtrim(Convert(char(2),			
			round((21+pg.CF10)/7,0)
			))			
----For start age<>0, Tran after PigStartDate, and 41 weeks or more after PigStartDate	
when pg.CF10<>0
and datediff(day,d2.WeekOfDate,d.WeekOfDate)>=0 
and round((21+pg.CF10+datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)>=41 then
	'WK41+'
----For start age=0, Tran before PigStartDate, and Calculated Pig Age is > 41 Weeks	
when pg.CF10=0
and datediff(day,d2.WeekOfDate,d.WeekOfDate)<0 
and round(((50-((50-st.Wgt)/1.1)+21)+ datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)>=41 then
	'WK41+'
----For start age<>0, Tran after PigStartDate, and less than 41 weeks after PigStartDate	
when pg.CF10<>0
and datediff(day,d2.WeekOfDate,d.WeekOfDate)>=0 
and round((21+pg.CF10+datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)<41 then
	'WK' +
	Replicate('0', 2 -
		Len(rtrim(
		Convert(char(2),
			round((21+pg.CF10+datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)
			)))) +
			+ rtrim(Convert(char(2),			
			round((21+pg.CF10+datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)			
			))	
----For anything that was not handled by the WeekOfAge case statements.	
else 'WK_Unknown'
end 'WeekOfAge',
case
when datediff(day,d2.WeekOfDate,d.WeekOfDate) > 202 Then 'PWK30+'
when datediff(day,d2.WeekOfDate,d.WeekOfDate)<0 then 'PWK01'
else
	'PWK' +
	Replicate('0', 2 -
	Len(rtrim(
	Convert(char(2),
		rtrim(
			datediff(day,d2.WeekOfDate,d.WeekOfDate)/7)+1
			)))) +
	+ rtrim(Convert(char(2),
		rtrim(
			datediff(day,d2.WeekOfDate,d.WeekOfDate)/7)+1
			))
end
'PhaseWeek',
rtrim(S.Description) GroupStatus,
sum(it.Qty) Qty
from [$(SolomonApp)].dbo.cftWeekDefinition WD with (nolock)
join [$(SolomonApp)].dbo.cftPGInvTran it with (nolock)					on it.TranDate<=WD.WeekEndDate
join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo d with (nolock)  on WD.WeekOfDate+7=d.DayDate
join [$(SolomonApp)].dbo.cftPigGroup pg with (nolock)					on pg.PigGroupID=it.PigGroupID
join [$(SolomonApp)].dbo.cfv_GroupStart st with (nolock)				on st.PigGroupID=pg.PigGroupID
join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo d2 with (nolock)	on d2.DayDate=st.StartDate
join [$(SolomonApp)].dbo.cftPigProdPod PP with (nolock)						on PP.PodID = PG.PigProdPodID
join [$(SolomonApp)].dbo.cftPigSystem PS with (nolock)						on PS.PigSystemID = PG.PigSystemID
join [$(SolomonApp)].dbo.cftPigProdPhase P with (nolock)					on P.PigProdPhaseID = PG.PigProdPhaseID
join [$(SolomonApp)].dbo.cftPGStatus S with (nolock)						on S.PGStatusID = PG.PGStatusID
join [$(SolomonApp)].dbo.cftBarn B									on B.ContactID=PG.SiteContactID and B.BarnNbr=PG.BarnNbr
join [$(SolomonApp)].dbo.cftFacilityType FT							on FT.FacilityTypeID=B.FacilityTypeID
left join [$(SolomonApp)].dbo.cfvPIGSALEREV psa							on psa.BatNbr=IT.SourceBatNbr and psa.RefNbr=IT.SourceRefNbr
left join	--PPig
		(select PMLoadID, min(MarketSaleTypeID) MarketSaleTypeID
		 from [$(SolomonApp)].dbo.cftPM
		 group by PMLoadID) pm
			on pm.PMLoadID=psa.PMLoadID
		where IT.acct in (
		'PIG DEATH',
		'PIG TRANSFER OUT',
		'PIG MOVE OUT',
		'PIG SALE',
		'TRANSPORT DEATH',
		'PIG INV ADJ'
		)
		and it.Reversal=0
		and d.DayDate <= PG.ActCloseDate+7
		and PG.PGStatusID = 'I'
		and ST.StartDate >='1/1/2006'
		group by
		case when d.FiscalYear='2009' and d.PICWeek='48' then 'PICWK48A'
		else 
		'PICWK' + Replicate('0',2-LEN(rtrim(d.PICWeek))) +
		rtrim(d.PICWeek) end,
		'PICYR' + Convert(char(4),d.PICYear),
		d.PICYear_Week,
		case when IT.acct='PIG SALE' and pm.MarketSaleTypeID='10' then 'PRIOR CUM TOP PIG SALE'
		when IT.acct='PIG SALE' and pm.MarketSaleTypeID<>'10' then 'PRIOR CUM CLOSE PIG SALE'
		when IT.acct='PIG SALE' and pm.MarketSaleTypeID is null then 'PRIOR CUM CLOSE PIG SALE'
		else 'PRIOR CUM '+rtrim(IT.acct)
		end,
		rtrim(PS.Description),
		rtrim(PP.Description),
		'FY '+convert(char(4),rtrim(d.FiscalYear)),
		'PG'+rtrim(PG.PigGroupID),
		'PG'+rtrim(PG.PigGroupID)+'-'+rtrim(PG.Description),
		case
		when PG.SingleStock <> 0
		and FT.Description='WF'
		and PG.PigProdPhaseID in ('NUR','FIN')
		then 'SS WF '
		when PG.SingleStock = 0
		and FT.Description='WF'
		and PG.PigProdPhaseID='NUR'
		then 'WF '
		else ''
		end
		+
		rtrim(P.PhaseDesc),
		case
		----For StartAge=0, not in NUR or WTF, Tran before PigStartDate
		when pg.CF10=0
		and pg.PigProdPhaseID in ('NUR','WTF')
		and datediff(day,d2.WeekOfDate,d.WeekOfDate)<0 then
			'WK03'
		----For StartAge=0, in NUR or WTF, and WeekOfAge >= 41 weeks
		when pg.CF10=0
		and pg.PigProdPhaseID in ('NUR','WTF')
		and datediff(day,d2.WeekOfDate,d.WeekOfDate)>=0
		and round((21 + datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)>=41 then
			'WK41+'
		----For StartAge=0, in NUR or WTF, and WeekOfAge < 41 weeks
		when pg.CF10=0
		and pg.PigProdPhaseID in ('NUR','WTF')
		and datediff(day,d2.WeekOfDate,d.WeekOfDate)>=0
		and round((21 + datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)<41 then
			'WK' +
			Replicate('0', 2 -
				Len(rtrim(
				Convert(char(2),
					round((21 + datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)
					)))) +
					+ rtrim(Convert(char(2),
					round((21 + datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)
					))
		----For StartAge=0, Uses StartWgt for Age, WeekOfAge >= 41 weeks	
		when pg.CF10=0
		and pg.PigProdPhaseID not in ('NUR','WTF')
		and datediff(day,d2.WeekOfDate,d.WeekOfDate)>=0
		and round(((50-((50-st.Wgt)/1.1)+21)+ datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)>=41 then
			'WK41+'
		----For StartAge=0, Uses StartWgt for Age, WeekOfAge >= 41 weeks	
		when pg.CF10=0
		and pg.PigProdPhaseID not in ('NUR','WTF')
		and datediff(day,d2.WeekOfDate,d.WeekOfDate)<0
		and round(((50-((50-st.Wgt)/1.1)+21))/7,0)>=41 then
			'WK41+'		
		----For StartAge=0, Uses StartWgt for Age, WeekOfAge < 41 weeks
		when pg.CF10=0
		and pg.PigProdPhaseID not in ('NUR','WTF')
		and datediff(day,d2.WeekOfDate,d.WeekOfDate)>=0
		and round(((50-((50-st.Wgt)/1.1)+21)+ datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)<41 then
			'WK' +
			Replicate('0', 2 -
				Len(rtrim(
				Convert(char(2),
					round(((50-((50-st.Wgt)/1.1)+21)+ datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)
					)))) +
					+ rtrim(Convert(char(2),
					round(((50-((50-st.Wgt)/1.1)+21)+ datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)			
					))
		----For start age<>0, Tran before PigStartDate
		when pg.CF10<>0
		and datediff(day,d2.WeekOfDate,d.WeekOfDate)<0 then
			'WK' +
			Replicate('0', 2 -
				Len(rtrim(
				Convert(char(2),
					round((21+pg.CF10)/7,0)
					)))) +
					+ rtrim(Convert(char(2),			
					round((21+pg.CF10)/7,0)
					))			
		----For start age<>0, Tran after PigStartDate, and 41 weeks or more after PigStartDate	
		when pg.CF10<>0
		and datediff(day,d2.WeekOfDate,d.WeekOfDate)>=0 
		and round((21+pg.CF10+datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)>=41 then
			'WK41+'
		----For start age=0, Tran before PigStartDate, and Calculated Pig Age is > 41 Weeks	
		when pg.CF10=0
		and datediff(day,d2.WeekOfDate,d.WeekOfDate)<0 
		and round(((50-((50-st.Wgt)/1.1)+21)+ datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)>=41 then
			'WK41+'
		----For start age<>0, Tran after PigStartDate, and less than 41 weeks after PigStartDate	
		when pg.CF10<>0
		and datediff(day,d2.WeekOfDate,d.WeekOfDate)>=0 
		and round((21+pg.CF10+datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)<41 then
			'WK' +
			Replicate('0', 2 -
				Len(rtrim(
				Convert(char(2),
					round((21+pg.CF10+datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)
					)))) +
					+ rtrim(Convert(char(2),			
					round((21+pg.CF10+datediff(day,d2.WeekOfDate,d.WeekOfDate))/7,0)			
					))	
		----For anything that was not handled by the WeekOfAge case statements.	
		else 'WK_Unknown'
		end,
		case
		when datediff(day,d2.WeekOfDate,d.WeekOfDate) > 202 Then 'PWK30+'
		when datediff(day,d2.WeekOfDate,d.WeekOfDate)<0 then 'PWK01'
		else
			'PWK' +
			Replicate('0', 2 -
			Len(rtrim(
			Convert(char(2),
				rtrim(
					datediff(day,d2.WeekOfDate,d.WeekOfDate)/7)+1
					)))) +
			+ rtrim(Convert(char(2),
				rtrim(
					datediff(day,d2.WeekOfDate,d.WeekOfDate)/7)+1
					))
		end,
		rtrim(S.Description)) PPig

left join -- PG
	(Select Distinct PG.PigGroupID,DD.PICYear_Week
	 From [$(SolomonApp)].dbo.cftPigGroup PG
	 left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo DD
		on PG.ActCloseDate = DD.DayDate
	 Where PG.ActCloseDate >= @blddate) PG	-- last 26 weeks.
--	 Where PG.ActCloseDate >= '1/1/2006') PG
			on right(rtrim(PPig."Group Number"),5) = PG.PigGroupID

Where PPig.Time <= PG.PICYear_Week


	
SELECT @Error = @@ERROR, @RowCount = @@ROWCOUNT IF @Error <> 0 GOTO ERR_Common;

SET @RecordsProcessed = @RowCount
SET @Comments = 'Completed successfully - [dbo].[cft_ASOLivG_priorcumclosed], '
                + CAST(@RecordsProcessed AS VARCHAR)
                + ' records processed'
 IF @LOG='Y' or @Error!=0
	BEGIN
	EXEC [$(CFFDB)].dbo.cfp_ProcessLog @DatabaseName,@ProcessName, @ProcessStatus, @StartDate, 
                   @EndDate, @RecordsProcessed, @Comments, @Error, @Criteria
	END
SET  @StepMsg = @Comments
EXEC [$(CFFDB)].dbo.cfp_PrintTs @StepMsg	

----------- end of process
               
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

	  




















GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_cube_ASOLivG_priorcumclosed_eb] TO [SE\ssis_datareader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_cube_ASOLivG_priorcumclosed_eb] TO [SSRS_operator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_cube_ASOLivG_priorcumclosed_eb] TO [SE\ssis_datawriter]
    AS [dbo];


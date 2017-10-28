
-- =============================================
-- Author:  mdawson
-- Create date: 09/14/2008
-- Update: 06/16/2011 ddahle -- Created for Changes to the Interstate Pig Movement By State changes report.
-- =============================================

CREATE procedure [dbo].[cfp_REPORT_INTERSTATE_PIG_MOVEMENTS_BY_STATE_new]
(     @StartDate datetime
,     @EndDate datetime
,     @SourceContactID varchar(8000)
,     @VetContactID varchar(8000) = NULL
,     @SourceState varchar(8000) = NULL
,     @DestState varchar(8000) = NULL
,     @ShowChanges bit = NULL
,     @ChangeStartDate datetime
,     @ChangeEndDate datetime)
as

IF 1 = 0 
BEGIN 

	SELECT 
		EstimatedQty		= CAST( NULL AS smallint ) 
	  , CpnyID				= CAST( NULL AS char(10) ) 
	  , MovementDate		= CAST( NULL AS smalldatetime ) 
	  , PMSystemID			= CAST( NULL AS char(2) ) 
	  , SourceFarm			= CAST( NULL AS char(50) ) 
	  , PigGenderTypeID		= CAST( NULL AS char(6) ) 
	  , DestFarm			= CAST( NULL AS varchar(103) ) 
	  , SAdd1				= CAST( NULL AS char(30) ) 
	  , SAdd2				= CAST( NULL AS char(30) ) 
	  , DestContactID		= CAST( NULL AS char(10) ) 
	  , SCity				= CAST( NULL AS char(30) ) 
	  , SState				= CAST( NULL AS char(3) ) 
	  , SZip				= CAST( NULL AS char(10) ) 
	  , SCounty				= CAST( NULL AS char(30) ) 
	  , sPremise			= CAST( NULL AS char(30) ) 
	  , dPremise			= CAST( NULL AS char(30) ) 
	  , DAdd1				= CAST( NULL AS char(30) ) 
	  , DAdd2				= CAST( NULL AS char(30) ) 
	  , DCity				= CAST( NULL AS char(30) ) 
	  , DState				= CAST( NULL AS char(3) ) 
	  , DZip				= CAST( NULL AS char(10) ) 
	  , DCounty				= CAST( NULL AS char(30) ) 
	  , DPhone				= CAST( NULL AS nvarchar(13) ) 
	  , VetVisitDate		= CAST( NULL AS datetime ) 
	  , SPhone				= CAST( NULL AS nvarchar(13) ) 
	  , PigType				= CAST( NULL AS char(30) ) 
	  , VetContactID		= CAST( NULL AS varchar(6) ) 
	  , VetName				= CAST( NULL AS char(50) ) 
	  , AccreditationNumber	= CAST( NULL AS varchar(10) ) 
	  , PICWeek				= CAST( NULL AS smallint ) 
	  , WeekOfDate			= CAST( NULL AS smalldatetime ) 
	  , PigWeight			= CAST( NULL AS varchar(3) ) 
	  , PodName				= CAST( NULL AS varchar(30) ) 
	  , LoadNumber			= CAST( NULL AS char(10) ) 
	  , IndLoadNumber		= CAST( NULL AS char(10) ) 
	  , LoadingTime			= CAST( NULL AS varchar(8) ) 
	  , SourceSiteID		= CAST( NULL AS char(4) ) 
	  , SourceContactID		= CAST( NULL AS char(10) ) 
	  , SourceNAIS			= CAST( NULL AS varchar(7) ) 
	  , DestSiteID			= CAST( NULL AS char(4) ) 
	  , DestNAIS			= CAST( NULL AS varchar(7) ) 
	  , Trucker				= CAST( NULL AS char(50) ) 
	  , ServiceManager		= CAST( NULL AS char(50) ) 
	  , VetPhoneNbr			= CAST( NULL AS nvarchar(13) ) 
	  , VetAddress1			= CAST( NULL AS char(30) ) 
	  , VetAddress2			= CAST( NULL AS char(30) ) 
	  , VetCity				= CAST( NULL AS char(30) ) 
	  , VetState			= CAST( NULL AS char(3) ) 
	  , VetZip				= CAST( NULL AS char(10) ) ; 

END

create table #SourceContact_Temp (ContactID char(6))
insert into #SourceContact_Temp select * from dbo.cffn_SPLIT_STRING(@SourceContactID,',')

create table #Vet_Temp (ContactID char(6))
insert into #Vet_Temp select * from dbo.cffn_SPLIT_STRING(@VetContactID,',')

create table #SourceState_Temp (State char(2))
insert into #SourceState_Temp select * from dbo.cffn_SPLIT_STRING(@SourceState,',')

create table #DestState_Temp (State char(2))
insert into #DestState_Temp select * from dbo.cffn_SPLIT_STRING(@DestState,',')

declare @SelectSQL varchar(8000)
declare @ShowChangesJoin varchar(1000)
declare @SourceContactJoin varchar(1000)
declare @VetJoin varchar(1000)
declare @SourceStateJoin varchar(1000)
declare @DestStateJoin varchar(1000)
declare @Where varchar(1000)
declare @OrderBy varchar(1000)

set @SelectSQL = 'select distinct v.* from cfv_REPORT_INTERSTATE_PIG_MOVEMENTS_new V '

IF @ShowChanges = 1
begin
      set @ShowChangesJoin = 'join (select distinct PMID, PMLoadID from dbo.cftPMChanges (NOLOCK) '
      + 'where ChangeDate between ''' + cast(@ChangeStartDate as varchar) + ''' and ''' + cast(@ChangeEndDate as varchar) + ''') PMC '
            + 'on pmc.PMID = v.IndLoadNumber '
            + 'and pmc.PMLoadID = v.LoadNumber '
end
else
      set @ShowChangesJoin = ''

set @SourceContactJoin = 'join #SourceContact_Temp SourceContact_Temp '
      + 'on SourceContact_Temp.ContactID = v.SourceContactID '

IF @VetContactID IS NOT NULL
begin
      set @VetJoin = 'join #Vet_Temp Vet_Temp '
            + 'on Vet_Temp.ContactID = v.VetContactID '
end
else
      set @VetJoin = ''

IF @SourceState IS NOT NULL
begin
      set @SourceStateJoin = 'join #SourceState_Temp SourceState_Temp '
            + 'on SourceState_Temp.State = v.SState '
end
else
      set @SourceStateJoin = ''

IF @DestState IS NOT NULL
begin
      set @DestStateJoin = 'join #DestState_Temp DestState_Temp '
            + 'on DestState_Temp.State = v.DState '
end
else
      set @DestStateJoin = ''

set @Where = 'where (v.MovementDate between ''' + cast(@StartDate as varchar) + ''' and ''' + cast(@EndDate as varchar) + ''') and v.PigType in (''Wean'', ''Feeder'')'

set @OrderBy = 'order by v.MovementDate, v.SourceFarm'

set @SelectSQL = @SelectSQL + @ShowChangesJoin + @SourceContactJoin + @VetJoin + @SourceStateJoin + @DestStateJoin
      + @Where + @OrderBy

print @SelectSQL
EXECUTE (@SelectSQL)

drop table #SourceContact_Temp
drop table #Vet_Temp
drop table #SourceState_Temp
drop table #DestState_Temp


SET ANSI_NULLS OFF


GO
GRANT CONTROL
    ON OBJECT::[dbo].[cfp_REPORT_INTERSTATE_PIG_MOVEMENTS_BY_STATE_new] TO [MSDSL]
    AS [dbo];


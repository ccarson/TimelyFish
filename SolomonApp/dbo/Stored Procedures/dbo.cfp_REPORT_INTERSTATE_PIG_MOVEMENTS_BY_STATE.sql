
-- =============================================
-- Author:  mdawson
-- Create date: 09/14/2008
-- Update: 06/16/2011 ddahle -- Created for Changes to the Interstate Pig Movement By State changes report.
-- =============================================

CREATE procedure [dbo].[cfp_REPORT_INTERSTATE_PIG_MOVEMENTS_BY_STATE]
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

set @SelectSQL = 'select distinct v.* from cfv_REPORT_INTERSTATE_PIG_MOVEMENTS V '

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
    ON OBJECT::[dbo].[cfp_REPORT_INTERSTATE_PIG_MOVEMENTS_BY_STATE] TO [MSDSL]
    AS [dbo];


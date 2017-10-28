
create procedure [dbo].[cfp_REPORT_INTERSTATE_PIG_MOVEMENTS_old]
(	@StartDate datetime
,	@EndDate datetime
,	@SourceContactID varchar(8000)
,	@SourceState varchar(2) = NULL
,	@DestState varchar(2) = NULL
,	@ShowChanges bit = NULL)
as

create table #SourceContact_Temp (ContactID char(6))
insert into #SourceContact_Temp select * from dbo.cffn_SPLIT_STRING(@SourceContactID,',')

IF @ShowChanges <> 1
BEGIN
	select v.* 
	from cfv_REPORT_INTERSTATE_PIG_MOVEMENTS v
	join #SourceContact_Temp SourceContact_Temp
		on SourceContact_Temp.ContactID = v.SourceContactID
	where v.MovementDate between @StartDate and @EndDate 
	and SState like isnull(@SourceState,'%')
	and DState like isnull(@DestState,'%')
	order by v.MovementDate, v.SourceFarm
END
ELSE
BEGIN
	select v.* 
	from dbo.cfv_REPORT_INTERSTATE_PIG_MOVEMENTS v
	join (select distinct PMID, PMLoadID, PrevMovementDate from dbo.cftPMChanges (nolock)) pmc
		on pmc.PMID = v.IndLoadNumber
		and pmc.PMLoadID = v.LoadNumber
	join #SourceContact_Temp SourceContact_Temp
		on SourceContact_Temp.ContactID = v.SourceContactID
	where (v.MovementDate between @StartDate and @EndDate or pmc.PrevMovementDate between @StartDate and @EndDate)
	and SState like isnull(@SourceState,'%')
	and DState like isnull(@DestState,'%')
	order by v.MovementDate, v.SourceFarm
END
drop table #SourceContact_Temp


CREATE procedure [dbo].[cfp_SITE_SELECT_INTERSTATE_MOVEMENTS_REPORT]
(	@StartDate datetime
,	@EndDate datetime
,	@SourceState varchar(8000)
,	@DestState varchar(8000)
,	@VetContactID varchar(8000))
as
create table #SourceState_Temp (State char(2))
insert into #SourceState_Temp select * from dbo.cffn_SPLIT_STRING(@SourceState,',')

create table #DestState_Temp (State char(2))
insert into #DestState_Temp select * from dbo.cffn_SPLIT_STRING(@DestState,',')

create table #Vet_Temp (ContactID char(6))
insert into #Vet_Temp select * from dbo.cffn_SPLIT_STRING(@VetContactID,',')


SELECT   Distinct 
	RTRIM(pm.SourceContactID) as SourceContactID
,	RTRIM(cs.ContactName) as SourceFarm
FROM         dbo.cftPM pm (nolock)
LEFT JOIN cftHealthService h ON h.ContactID=pm.SourceContactID
LEFT JOIN cftSite s (nolock) on pm.SourceContactID=s.ContactID
LEFT JOIN cftContact cs (nolock) ON pm.SourceContactID=cs.ContactID
LEFT JOIN dbo.cftPigOffload o (nolock) on pm.PMID=o.SrcPMID
LEFT JOIN cftPM op (nolock) on o.DestPMID=op.PMID
JOIN cftContactAddress SourceContactAddress
	on SourceContactAddress.ContactID = pm.SourceContactID
	and SourceContactAddress.AddressTypeID = '01'
JOIN cftAddress SourceAddress
	on SourceAddress.AddressID = SourceContactAddress.AddressID
JOIN cftContactAddress DestContactAddress
	on DestContactAddress.ContactID = pm.DestContactID
	and DestContactAddress.AddressTypeID = '01'
JOIN cftAddress DestAddress
	on DestAddress.AddressID = DestContactAddress.AddressID
JOIN #SourceState_Temp SourceState_Temp
	on SourceState_Temp.State = SourceAddress.State
JOIN #DestState_Temp DestState_Temp
	on DestState_Temp.State = DestAddress.State
JOIN #Vet_Temp Vet_Temp
	on Vet_Temp.ContactID = h.VetContactID


WHERE (pm.TattooFlag<>0 or op.TattooFlag<>0)
and pm.Highlight<>255
and left(pm.TranSubTypeID,1)<>'O'
and pm.MovementDate between @StartDate and @EndDate
ORDER BY RTRIM(cs.ContactName)

drop table #SourceState_Temp
drop table #DestState_Temp
drop table #Vet_Temp

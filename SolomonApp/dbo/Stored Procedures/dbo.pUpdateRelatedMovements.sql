--used in Health Assurance Test app to update all movements related/affected
--by a test at a specific site on a specific date
CREATE PROC [dbo].[pUpdateRelatedMovements]
	@ContactID as int,
	@TestDate as smalldatetime,
	@Status as varchar(1)=''
AS
	DECLARE @NbrDays as smallint
	DECLARE @EndDate as smalldatetime
	--IF @ContactID=1217 
	--	BEGIN Set @NbrDays=7 END
	--ELSE
	--	BEGIN Set @NbrDays=28 END
	Set @NbrDays=(Select TOP 1 AuthorizeDays from SiteTestSchedule 
			where SiteContactID=@ContactID
			and EffectiveDate<=@TestDate order by EffectiveDate desc)
	Set @EndDate=@TestDate+@NbrDays

	Update SolomonApp.dbo.cftPM 
	set SourceTestStatus=@Status
	from SolomonApp.dbo.cftPM pm 
	LEFT JOIN SolomonApp.dbo.cftPMAudit a on pm.PMID=a.PMID 
		where (cast(SourceContactID as int)= @ContactID )
		 and (MovementDate between  @TestDate  and  @EndDate) and a.PMID is null --and MovementSystem=1
	Update SolomonApp.dbo.cftPM 
	set SourceTestStatus='' 
	from SolomonApp.dbo.cftPM pm 
	LEFT JOIN SolomonApp.dbo.cftPMAudit a on pm.PMID=a.PMID 
	where (cast(SourceContactID as int)= @ContactID )
		 and (MovementDate between  @TestDate  and  @EndDate) --and MovementSystem=1
		 and PigTypeID='02' and a.PMID is null
	if (@Status)='2'
	BEGIN
	Update SolomonApp.dbo.cftPM 
	set DestTestStatus=@Status
	from SolomonApp.dbo.cftPM pm 
	LEFT JOIN SolomonApp.dbo.cftPMAudit a on pm.PMID=a.PMID 
		where (Cast(DestContactID as int)=@ContactID)
		 and MovementDate between  @TestDate  and  @EndDate --and MovementSystem=1
		 and PigTypeID<>'04' and PigTypeID<>'05' and a.PMID is null
	END
	else
	BEGIN
	Update SolomonApp.dbo.cftPM 
	set DestTestStatus=@Status
	from SolomonApp.dbo.cftPM pm 
	LEFT JOIN SolomonApp.dbo.cftPMAudit a on pm.PMID=a.PMID 
	where (cast(DestContactID as int)=@ContactID)
		 and (MovementDate between  @TestDate  and  @EndDate)
		 and PMSystemID='01'
		 and PigTypeID in ('01','02','03','06','08','09') and a.PMID is null
	END
	--Select @NbrDays as test
	--Select @Status as test
	--Select @EndDate as test

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pUpdateRelatedMovements] TO [MSDSL]
    AS [dbo];


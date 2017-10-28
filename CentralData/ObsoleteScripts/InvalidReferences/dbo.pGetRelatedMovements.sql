--used in Health Assurance Test app to find all movements related/affected
--by a test at a specific site on a specific date
CREATE PROC [dbo].[pGetRelatedMovements]
	@ContactID as int,
	@TestDate as smalldatetime,
	@RecordTypeCode as int
AS

DECLARE @NbrDays as smallint, @EndDate as smalldatetime
IF (@RecordTypeCode in(0,3))
BEGIN
	
	Set @NbrDays=(Select TOP 1 AuthorizeDays from SiteTestSchedule 
			where SiteContactID=@ContactID
			and EffectiveDate<=@TestDate order by EffectiveDate desc)


	Select ID , SourceContactID, MovementDate,SourceTestStatus, s.ContactName as SourceFarm, SourceBarnNbr, 
		PigGenderTypeID, EstimatedQty, DestTestStatus, d.ContactName as Destination, DestBarnNbr, TattooFlag, h.VetVisitDate, Walkthrough
	from [$(SolomonApp)].dbo.cftPM pm
	Left JOIN [$(SolomonApp)].dbo.cftContact s on pm.SourceContactID=s.ContactID
	LEFT JOIN [$(SolomonApp)].dbo.cftContact d on pm.DestContactID=d.ContactID 
	LEFT JOIN [$(SolomonApp)].dbo.cftHealthService h on pm.SourceContactID=h.ContactID
	 where (cast(SourceContactID as int)= @ContactID or cast(DestContactID as int)=@ContactID)
		 and MovementDate between @TestDate and @TestDate+@NbrDays
		 and PigTypeID in ('01','02','03','06','08','09')
	 order by MovementDate, Destination
END
IF (@RecordTypeCode=4)
BEGIN
	
	Set @NbrDays=(Select TOP 1 PostArriveNbrDays from SiteTestSchedule 
			where SiteContactID=@ContactID
			and EffectiveDate<=@TestDate order by EffectiveDate desc)
	Set @TestDate=DateAdd(d,-1*@NbrDays,@TestDate)
/*	IF @NbrDays<0 
		BEGIN Set @EndDate=DateAdd(d,-1*@NbrDays,@TestDate)
			  SET @TestDate=DateAdd(d,-1*@NbrDays,@TestDate)
		END
	ELSE	
		BEGIN SET @TestDate=DateAdd
	Set @EndDate=DateAdd(d,@nbrDays,@TestDate)
*/
	Select ID , SourceContactID, MovementDate,SourceTestStatus, s.ContactName as SourceFarm, SourceBarnNbr, 
		PigGenderTypeID, EstimatedQty, DestTestStatus, d.ContactName as Destination, DestBarnNbr, TattooFlag, h.VetVisitDate, Walkthrough
	from [$(SolomonApp)].dbo.cftPM pm
	Left JOIN [$(SolomonApp)].dbo.cftContact s on pm.SourceContactID=s.ContactID
	LEFT JOIN [$(SolomonApp)].dbo.cftContact d on pm.DestContactID=d.ContactID 
	LEFT JOIN [$(SolomonApp)].dbo.cftHealthService h on pm.SourceContactID=h.ContactID
	 where (cast(DestContactID as int)=@ContactID)
		 and MovementDate =@TestDate
		 and PigTypeID in ('01','02','03','06','08','09')
	 order by MovementDate, Destination
END
IF (@RecordTypeCode=5)
BEGIN
	Select ID, SourceContactID, MovementDate,SourceTestStatus, s.ContactName as SourceFarm, SourceBarnNbr, 
		PigGenderTypeID, EstimatedQty, DestTestStatus, d.ContactName as Destination, DestBarnNbr, 
	TattooFlag, h.VetVisitDate, Walkthrough,pmSystemID
	from [$(SolomonApp)].dbo.cftPM pm
	Left JOIN [$(SolomonApp)].dbo.cftContact s on pm.SourceContactID=s.ContactID
	LEFT JOIN [$(SolomonApp)].dbo.cftContact d on pm.DestContactID=d.ContactID 
	LEFT JOIN [$(SolomonApp)].dbo.cftHealthService h on pm.SourceContactID =h.ContactID
	 where (cast(SourceContactID as int)= @ContactID) and PigTypeID<>'04' and PigTypeID<>'05'
		 and MovementDate between  @TestDate  and  @TestDate+30 
		--and PMSystemID='01'
		 and TattooFlag<>0
	 order by MovementDate, d.ContactName
END



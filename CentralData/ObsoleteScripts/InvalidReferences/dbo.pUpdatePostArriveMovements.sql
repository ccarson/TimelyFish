--used in Health Assurance Test app to update all movements related/affected
--by a test at a specific site on a specific date
CREATE PROC [dbo].[pUpdatePostArriveMovements]
	@ContactID as int,
	@TestDate as smalldatetime,
	@Status as varchar(1)=''
AS
	DECLARE @NbrDays as smallint
	
	--IF @ContactID=1217 
	--	BEGIN Set @NbrDays=7 END
	--ELSE
	--	BEGIN Set @NbrDays=28 END
	Set @NbrDays=(Select TOP 1 PostArriveNbrDays from SiteTestSchedule 
			where SiteContactID=@ContactID
			and EffectiveDate<=@TestDate order by EffectiveDate desc)
	SET @TestDate=DateAdd(d,@NbrDays*-1,@TestDate)
	Update [$(SolomonApp)].dbo.cftPM set DestTestStatus=@Status
	where (cast(DestContactID as int)=@ContactID)
		 and MovementDate = @TestDate
		 and PMSystemID='01'
		 and PigTypeID in ('06')



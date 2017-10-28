--used in Health Assurance Test app to update all movements related/affected
--by a walkthrough at a specific site on a specific date
CREATE PROC [dbo].[pUpdateRelatedWalkMovements]
	@ContactID as int,
	@TestDate as smalldatetime,
	@Status as int=0
AS
	Declare @EndDate as smalldatetime
	SET @EndDate=DateAdd(d,30,@TestDate)
	Update SolomonApp.dbo.cftPM set Walkthrough=@Status
	where (cast(SourceContactID as int)= @ContactID)
		 and MovementDate between  @TestDate  and  @EndDate --and PMSystemID='01'
		 and TattooFlag<>0 and PigTypeID<>'04' and PigTypeID<>'05'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pUpdateRelatedWalkMovements] TO [MSDSL]
    AS [dbo];


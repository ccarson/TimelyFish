Create Procedure dbo.pSourceBarnTotals 
	@ContactID int,
	@ReferenceDate smalldatetime
	
	As
	DECLARE @BegDate smalldatetime, @EndDate smalldatetime
	Select @EndDate=(Select Max(MovementDate) from PigMovement
		WHERE MovementDate<DateAdd(day,-28,@ReferenceDate) and DestinationContactID=@ContactID)
	Select @BegDate=(@EndDate-28)

	select 
		BarnNbr = Min(vb.BarnNbr), 
		FirstFillDate = Min(pm.MovementDate), 
		LastFillDate = Max(pm.MovementDate),
		EmptyDate=(Select Min(MovementDate) from PigMovement where SourceContactID=@ContactID
			and SourceBarnID=vb.BarnID and MovementDate >  min(pm.MovementDate)
			Group by SourceContactID, SourceBarnID),
		DaysIN=DateDiff("d",Min(pm.MovementDate),(Select Min(MovementDate) from PigMovement where SourceContactID=@ContactID
			and SourceBarnID=vb.BarnID and MovementDate > min(pm.MovementDate)
			Group by SourceContactID, SourceBarnID))
		from dbo.pigmovement pm
		RIGHT OUTER JOIN dbo.vbarn vb ON pm.destinationcontactid = vb.contactid and pm.DestinationBarnID = vb.BarnID
		Where pm.MovementDate between @BegDate and @EndDate and pm.DestinationContactID = @ContactID
		Group By pm.DestinationContactID, DestinationBarnID, vb.BarnID
		Order By pm.DestinationContactID, DestinationBarnID


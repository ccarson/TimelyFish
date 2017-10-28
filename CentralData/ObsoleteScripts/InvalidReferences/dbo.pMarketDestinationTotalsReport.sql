CREATE PROC [dbo].[pMarketDestinationTotalsReport] 
	@CurrDate smalldatetime,
	@BegDate smalldatetime
	
	As

	Declare @EndDate smalldatetime

	Select @EndDate = @BegDate + 6


	Select Distinct ContactID, 
		 md.ContactName as DestinationName,
		MovementDate=@CurrDate,
		MovementDay=(datename(weekday, @CurrDate)),
		DailyTotal= (Select IsNull(Sum(EstimatedQty),0) From MarketMovement
			Where ((DestinationSiteID = md.ContactID)) AND
			MovementDate = @CurrDate),
		WeeklyTotal=(Select IsNull(Sum(EstimatedQty),0) From MarketMovement
			Where ((DestinationSiteID = md.ContactID)) AND
			MovementDate Between @BegDate and @EndDate),
		DailyAvgWgt = (Select Round(AVG(ActualWgt),2) From MarketMovement
			Where ((DestinationSiteID = md.ContactID)) AND
			MovementDate = @CurrDate and isnull(actualwgt,0)>0),
		WeeklyAvgWgt = (Select Round(AVG(ActualWgt),2) From MarketMovement
			Where ((DestinationSiteID = md.ContactID)) AND
			MovementDate Between @BegDate and @EndDate and isnull(actualwgt,0)>0),
		ProjectedDailyAvgWgt = (SELECT ROUND(AVG(dbo.fxn_dec_getMedian(ISNULL(EstimatedWgt, ''))), 2) From MarketMovement
			Where ((DestinationSiteID = md.ContactID)) AND
			MovementDate = @CurrDate and isnull(EstimatedWgt,0)>0),
		ProjectedWeeklyAvgWgt = (SELECT ROUND(AVG(dbo.fxn_dec_getMedian(ISNULL(EstimatedWgt, ''))), 2) From MarketMovement
			Where ((DestinationSiteID = md.ContactID)) AND
			MovementDate Between @BegDate and @EndDate and isnull(EstimatedWgt,0)>0)
	From dbo.vMarketDestination md
		      Where (md.TrackTotals=-1) and (Select IsNull(Sum(EstimatedQty),0) From MarketMovement
			Where ((DestinationSiteID = md.ContactID)) AND
			MovementDate Between @BegDate and @EndDate)>0
	Union Select Distinct 0 as Contact, 'Un-Assigned' as DestinationName,
		MovementDate=@CurrDate,
		MovementDay=(datename(weekday, @CurrDate)),
		DailyTotal= (Select IsNull(Sum(EstimatedQty),0) From MarketMovement
			Where (DestinationSiteID is null or DestinationSiteID='') AND
			MovementDate = @CurrDate and HeadTypeID<40),
		WeeklyTotal=(Select IsNull(Sum(EstimatedQty),0) From MarketMovement
			Where (DestinationSiteID is null or DestinationSiteID='') AND
			MovementDate Between @BegDate and @EndDate and HeadTypeID<40),
		DailyAvgWgt= (Select Round(AVG(ActualWgt),2) From MarketMovement
			Where (DestinationSiteID is null or DestinationSiteID='') AND
			MovementDate = @CurrDate and HeadTypeID<40 and isnull(actualwgt,0)>0),
		WeeklyAvgWgt=(Select Round(AVG(ActualWgt),2) From MarketMovement
			Where (DestinationSiteID is null or DestinationSiteID='') AND
			MovementDate Between @BegDate and @EndDate and HeadTypeID<40 and isnull(actualwgt,0)>0),
		ProjectedDailyAvgWgt = (SELECT ROUND(AVG(dbo.fxn_dec_getMedian(ISNULL(EstimatedWgt, ''))), 2) From MarketMovement
			Where (DestinationSiteID is null or DestinationSiteID='') AND
			MovementDate = @CurrDate and HeadTypeID<40 and isnull(EstimatedWgt,0)>0),
		ProjectedWeeklyAvgWgt=(SELECT ROUND(AVG(dbo.fxn_dec_getMedian(ISNULL(EstimatedWgt, ''))), 2) From MarketMovement
			Where (DestinationSiteID is null or DestinationSiteID='') AND
			MovementDate Between @BegDate and @EndDate and HeadTypeID<40 and isnull(EstimatedWgt,0)>0)
		From dbo.MarketMovement mm
	Union Select Distinct 1 as Contact, 'Alternative Market' as DestinationName,
		MovementDate=@CurrDate,
		MovementDay=(datename(weekday, @CurrDate)),
		DailyTotal= (Select IsNull(Sum(EstimatedQty),0) From MarketMovement
			Where (DestinationSiteID =816) AND
			MovementDate = @CurrDate and HeadTypeID<40),
		WeeklyTotal=(Select IsNull(Sum(EstimatedQty),0) From MarketMovement
			Where (DestinationSiteID =816) AND
			MovementDate Between @BegDate and @EndDate and HeadTypeID<40),
		DailyAvgWgt= (Select Round(AVG(ActualWgt),2) From MarketMovement
			Where (DestinationSiteID =816) AND
			MovementDate = @CurrDate and HeadTypeID<40 and isnull(actualwgt,0)>0),
		WeeklyAvgWgt=(Select Round(AVG(ActualWgt),2) From MarketMovement
			Where (DestinationSiteID =816) AND
			MovementDate Between @BegDate and @EndDate and HeadTypeID<40 and isnull(actualwgt,0)>0),
		ProjectedDailyAvgWgt= (SELECT ROUND(AVG(dbo.fxn_dec_getMedian(ISNULL(EstimatedWgt, ''))), 2) From MarketMovement
			Where (DestinationSiteID =816) AND
			MovementDate = @CurrDate and HeadTypeID<40 and isnull(EstimatedWgt,0)>0),
		ProjectedWeeklyAvgWgt=(SELECT ROUND(AVG(dbo.fxn_dec_getMedian(ISNULL(EstimatedWgt, ''))), 2) From MarketMovement
			Where (DestinationSiteID =816) AND
			MovementDate Between @BegDate and @EndDate and HeadTypeID<40 and isnull(EstimatedWgt,0)>0)
		From dbo.MarketMovement mm
	Union Select 99998 as Contact, 'Total Marketable' as DestinationName,
		MovementDate=@CurrDate,
		MovementDay=(datename(weekday, @CurrDate)),
		DailyTotal= (Select IsNull(Sum(EstimatedQty),0) From MarketMovement
			Where (HeadTypeID<40) AND
			MovementDate = @CurrDate),
		WeeklyTotal=(Select IsNull(Sum(EstimatedQty),0) From MarketMovement
			Where (HeadTypeID<40) AND
			MovementDate Between @BegDate and @EndDate),
		DailyAvgWgt= (Select Round(AVG(ActualWgt),2) From MarketMovement
			Where (HeadTypeID<40) AND
			MovementDate = @CurrDate and isnull(actualwgt,0)>0),
		WeeklyAvgWgt=(Select Round(AVG(ActualWgt),2) From MarketMovement
			Where (HeadTypeID<40) AND
			MovementDate Between @BegDate and @EndDate and isnull(actualwgt,0)>0),
		ProjectedAvgWgt=(SELECT ROUND(AVG(dbo.fxn_dec_getMedian(ISNULL(EstimatedWgt, ''))), 2) From MarketMovement
			Where (HeadTypeID<40) AND
			MovementDate = @CurrDate and isnull(EstimatedWgt,0)>0),
		ProjectedAvgWgt=(SELECT ROUND(AVG(dbo.fxn_dec_getMedian(ISNULL(EstimatedWgt, ''))), 2) From MarketMovement
			Where (HeadTypeID<40) AND
			MovementDate Between @BegDate and @EndDate and isnull(EstimatedWgt,0)>0)
	From dbo.vMarketDestination md
	Union Select 99999 as Contact, 'Total Non-Marketable' as DestinationName,
		MovementDate=@CurrDate,
		MovementDay=(datename(weekday, @CurrDate)),
		DailyTotal= (Select IsNull(Sum(EstimatedQty),0) From MarketMovement
			Where (HeadTypeID>=40) AND
			MovementDate = @CurrDate),
		WeeklyTotal=(Select IsNull(Sum(EstimatedQty),0) From MarketMovement
			Where (HeadTypeID>=40) AND
			MovementDate Between @BegDate and @EndDate),
		DailyAvgWgt= (Select Round(AVG(ActualWgt),2) From MarketMovement
			Where (HeadTypeID>=40) AND
			MovementDate = @CurrDate and isnull(actualwgt,0)>0),
		WeeklyAvgWgt=(Select Round(AVG(ActualWgt),2) From MarketMovement
			Where (HeadTypeID>=40) AND
			MovementDate Between @BegDate and @EndDate and isnull(actualwgt,0)>0),
		ProjectedDailyAvgWgt= (SELECT ROUND(AVG(dbo.fxn_dec_getMedian(ISNULL(EstimatedWgt, ''))), 2) From MarketMovement
			Where (HeadTypeID>=40) AND
			MovementDate = @CurrDate and isnull(EstimatedWgt,0)>0),
		ProjectedWeeklyAvgWgt=(SELECT ROUND(AVG(dbo.fxn_dec_getMedian(ISNULL(EstimatedWgt, ''))), 2) From MarketMovement
			Where (HeadTypeID>=40) AND
			MovementDate Between @BegDate and @EndDate and isnull(EstimatedWgt,0)>0)
	From dbo.vMarketDestination md
	Union Select 99990 as Contact, 'Total PFEU' as DestinationName,
		MovementDate=@CurrDate,
		MovementDay=(datename(weekday, @CurrDate)),
		DailyTotal= (Select IsNull(Sum(EstimatedQty),0) 
			From MarketMovement
			Where destinationsiteid = 555 -- Swift Worthington
			and pfeu = -1   		-- PFEU is checked
			--and arrivaltime is not null	-- Arrival Time has been set
			and ((datepart(hour, arrivaltime) not between 13 and 20) -- Mon-Wed NOT between 1PM - 8PM
			or 
			(datepart(weekday, movementdate) = 6 and datepart(hour, arrivaltime) < 13) -- Friday only before 1PM
			OR (arrivaltime is null))--Arrival time is blank
			--and (datepart(weekday, movementdate) <> 5) -- no Thursday
			AND MovementDate = @CurrDate),
		WeeklyTotal=(Select IsNull(Sum(EstimatedQty),0) 
			From MarketMovement
			Where destinationsiteid = 555 -- Swift Worthington
			and pfeu = -1   		-- PFEU is checked
			--and arrivaltime is not null	-- Arrival Time has been set
						and ((datepart(hour, arrivaltime) not between 13 and 20) -- Mon-Wed NOT between 1PM - 8PM
			or 
			(datepart(weekday, movementdate) = 6 and datepart(hour, arrivaltime) < 13) -- Friday only before 1PM
			OR (arrivaltime is null))--Arrival time is blank
			--and (datepart(weekday, movementdate) <> 5) -- no Thursday
			AND MovementDate Between @BegDate and @EndDate),
		DailyAvgWgt= (Select Round(AVG(ActualWgt),2)
			From MarketMovement
			Where destinationsiteid = 555 -- Swift Worthington
			and pfeu = -1   		-- PFEU is checked
			--and arrivaltime is not null	-- Arrival Time has been set
						and ((datepart(hour, arrivaltime) not between 13 and 20) -- Mon-Wed NOT between 1PM - 8PM
			or 
			(datepart(weekday, movementdate) = 6 and datepart(hour, arrivaltime) < 13) -- Friday only before 1PM
			OR (arrivaltime is null))--Arrival time is blank
			--and (datepart(weekday, movementdate) <> 5) -- no Thursday
			AND MovementDate = @CurrDate and isnull(actualwgt,0)>0),
		WeeklyAvgWgt=(Select Round(AVG(ActualWgt),2) From MarketMovement
			Where destinationsiteid = 555 -- Swift Worthington
			and pfeu = -1   		-- PFEU is checked
			--and arrivaltime is not null	-- Arrival Time has been set
						and ((datepart(hour, arrivaltime) not between 13 and 20) -- Mon-Wed NOT between 1PM - 8PM
			or 
			(datepart(weekday, movementdate) = 6 and datepart(hour, arrivaltime) < 13) -- Friday only before 1PM
			OR (arrivaltime is null))--Arrival time is blank
			--and (datepart(weekday, movementdate) <> 5) -- no Thursday
			AND MovementDate Between @BegDate and @EndDate and isnull(actualwgt,0)>0),
		ProjectedDailyAvgWgt= (SELECT ROUND(AVG(dbo.fxn_dec_getMedian(ISNULL(EstimatedWgt, ''))), 2) From MarketMovement
			Where destinationsiteid = 555 -- Swift Worthington
			and pfeu = -1   		-- PFEU is checked
			--and arrivaltime is not null	-- Arrival Time has been set
						and ((datepart(hour, arrivaltime) not between 13 and 20) -- Mon-Wed NOT between 1PM - 8PM
			or 
			(datepart(weekday, movementdate) = 6 and datepart(hour, arrivaltime) < 13) -- Friday only before 1PM
			OR (arrivaltime is null))--Arrival time is blank
			--and (datepart(weekday, movementdate) <> 5) -- no Thursday
			AND MovementDate = @CurrDate and isnull(EstimatedWgt,0)>0),
		ProjectedWeeklyAvgWgt=(SELECT ROUND(AVG(dbo.fxn_dec_getMedian(ISNULL(EstimatedWgt, ''))), 2) From MarketMovement
			Where destinationsiteid = 555 -- Swift Worthington
			and pfeu = -1   		-- PFEU is checked
			--and arrivaltime is not null	-- Arrival Time has been set
						and ((datepart(hour, arrivaltime) not between 13 and 20) -- Mon-Wed NOT between 1PM - 8PM
			or 
			(datepart(weekday, movementdate) = 6 and datepart(hour, arrivaltime) < 13) -- Friday only before 1PM
			OR (arrivaltime is null))--Arrival time is blank
			--and (datepart(weekday, movementdate) <> 5) -- no Thursday
			AND MovementDate Between @BegDate and @EndDate and isnull(EstimatedWgt,0)>0)
	From dbo.vMarketDestination md

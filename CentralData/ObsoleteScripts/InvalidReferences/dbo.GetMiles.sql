CREATE PROCEDURE [dbo].[GetMiles]
	@MovementDate as smalldatetime,
	@TruckerID as int
AS
DECLARE @StartSite as int
DECLARE @EndSite as int
DECLARE @Miles as Decimal
DECLARE @LastDestination as int
DECLARE @LastArrivalTime as smalldatetime
DECLARE Movement_Cursor CURSOR 
FOR SELECT SourceContactID, DestinationContactID, LoadTime, ArrivalTime
	FROM PigMovement
	WHERE TruckerID = @TruckerID AND MovementDate = @MovementDate
	ORDER BY LoadTime
OPEN Movement_Cursor
DECLARE @SourceContactID as int
DECLARE @DestinationContactID as int
DECLARE @LoadTime as smalldatetime
DECLARE @ArrivalTime as smalldatetime 
SET @StartSite = 0
SET @EndSite  = 0
SET @Miles = 0
FETCH NEXT FROM Movement_Cursor INTO @SourceContactID, @DestinationContactID, @LoadTime, @ArrivalTime
WHILE @@FETCH_STATUS=0
BEGIN
	 SET @LastArrivalTime = @ArrivalTime
	 SET @LastDestination = @DestinationContactID
	 SET @EndSite = @SourceContactID
	 If @StartSite <> 0 
	     Begin
	     SET @Miles = @Miles + dbo.CalcDistance(@StartSite, @EndSite)
	     END
	SET @StartSite = @SourceContactID
	if @@FETCH_STATUS = 0
	     BEGIN
		If @LastArrivalTime < @LoadTime
		    Begin
		       SET @Miles = @Miles + dbo.CalcDistance(@StartSite, @LastDestination)
		       SET @Miles = @Miles + dbo.CalcDistance(@LastDestination, @StartSite)
		       SET @StartSite = 0
		    End
	     END
	ELSE
	     Begin
    		SET @EndSite = @DestinationContactID
    		SET @Miles = @Miles + dbo.CalcDistance(@StartSite, @EndSite)
 	     End

END
CLOSE Movement_Cursor
DEALLOCATE Movement_Cursor
Return @Miles




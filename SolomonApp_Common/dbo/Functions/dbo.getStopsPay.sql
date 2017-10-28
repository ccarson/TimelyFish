
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2015-09-15	Doran Dahle New,  Moved the sql from the getRate Function.
===============================================================================
*/

Create Function [dbo].[getStopsPay]
	(@PMLoadID as varchar(10),@PMID as varchar(10))
	
RETURNS decimal(5,2)


AS
BEGIN
DECLARE @StopsPay decimal(5,2), @StopBaseCharge decimal(4,2)
SET @StopBaseCharge=50
SET @StopsPay = 0
IF @PMID=@PMLoadID --this load should display the rate
	BEGIN
		DECLARE @Stops smallint
		
		SET @Stops=0
		-- Get the number of Source stops
		SET @Stops=(Select Count(t.SourceContactID) from (Select Distinct SourceContactID from cftPM where PMLoadID=@PMLoadID) as t)
		-- Add in the number of Destination Stops
		SET @Stops=@Stops+(Select Count(t.DestContactID) from (Select Distinct DestContactID from cftPM where PMLoadID=@PMLoadID) as t)
		-- Now subtract one source and destination stop as we don't pay extra for one source and one destination
		SET @Stops=@Stops-2
		IF @Stops > 0 BEGIN SET @StopsPay = CAST ((@Stops * @StopBaseCharge) as decimal(5,2))  END
		
	END
ELSE
	BEGIN SET @StopsPay=0 END

RETURN @StopsPay 
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[getStopsPay] TO [MSDSL]
    AS [dbo];


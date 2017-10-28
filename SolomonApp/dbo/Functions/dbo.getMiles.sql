


CREATE Function [dbo].[getMiles] (@PMLoadID as varchar(10)) RETURNS Decimal(10,1) AS
BEGIN
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2013-12-23  BMD			Created to help with a SS used by Jason Williams in Transportation
                          Calculating miles distance code was taken from the "getRate" function
===============================================================================
*/
	DECLARE @SourceContactID varchar(6),  @LoadTime smalldatetime
	DECLARE @StartSite varchar(6), @EndSite varchar(6), @Miles decimal(10,6),@NewMiles as decimal(10,6)	
	
	DECLARE MilesCursor CURSOR LOCAL FORWARD_ONLY READ_ONLY FOR
		Select DestContactID,max(arrivaldate+CONVERT(CHAR(8),arrivaltime,24))
		from cftPm (NOLOCK) where PMLoadID=@PMLoadID
		group by DestContactID,TrailerWashFlag,DisinfectFlg
		union
		Select sourceContactID, min(movementdate+CONVERT(CHAR(8),loadingtime,24))
		from cftPm (NOLOCK) where PMLoadID=@PMLoadID
		group by sourceContactID,TrailerWashFlag,DisinfectFlg
		order by 2

	OPEN MilesCursor
		
	FETCH NEXT FROM MilesCursor INTO @SourceContactID ,@LoadTime
		
	SET @EndSite  = ''
	SET @Miles = 0
		
	WHILE @@FETCH_STATUS = 0
	BEGIN
	    SET @StartSite = @SourceContactID
	    IF @EndSite<>''
	       SET @NewMiles=(Select isnull(OneWayMiles,0) from vcfContactMilesMatrix 
					where SourceSite=@StartSite and DestSite=@EndSite)
		IF @NewMiles>0 BEGIN Set @Miles=@Miles+@NewMiles END
	    SET @EndSite = @SourceContactID
		
	    FETCH NEXT FROM MilesCursor INTO @SourceContactID,@LoadTime
	END
	
	RETURN @Miles
	
End


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[getMiles] TO PUBLIC
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[getMiles] TO [SOLOMON]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[getMiles] TO [SE\Earth~WTF~DataReader]
    AS [dbo];


GO
GRANT CONTROL
    ON OBJECT::[dbo].[getMiles] TO [MSDSL]
    AS [dbo];


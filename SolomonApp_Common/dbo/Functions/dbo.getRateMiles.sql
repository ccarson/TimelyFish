
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2015-09-15	Doran Dahle New,  Moved the sql from the getRate Function.
===============================================================================
*/

CREATE Function [dbo].[getRateMiles]
	(@PMLoadID as varchar(10),@PMID as varchar(10))
RETURNS Decimal(10,2)

AS
BEGIN

IF @PMID=@PMLoadID --this load should display the rate
	BEGIN
		DECLARE @StartSite varchar(6), @EndSite varchar(6), 
			@Miles decimal(10,6),@NewMiles as decimal(10,6)
			
		DECLARE @Wash smallint, @Disinfect smallint 
		DECLARE @SourceContactID varchar(6),  @LoadTime smalldatetime, @TrailerWashFlg smallint, @DisinfectFlg smallint
		
		DECLARE MilesCursor CURSOR LOCAL FORWARD_ONLY READ_ONLY FOR
		Select DestContactID,max(arrivaldate+CONVERT(CHAR(8),arrivaltime,24)),TrailerWashFlag,DisinfectFlg
		from cftPm where PMLoadID=@PMLoadID
		group by DestContactID,TrailerWashFlag,DisinfectFlg
		union
		Select sourceContactID, min(movementdate+CONVERT(CHAR(8),loadingtime,24)),TrailerWashFlag,DisinfectFlg
		from cftPm where PMLoadID=@PMLoadID
		group by sourceContactID,TrailerWashFlag,DisinfectFlg
		order by 2
				
		OPEN MilesCursor
		
		FETCH NEXT FROM MilesCursor INTO @SourceContactID ,@LoadTime, @TrailerWashFlg, @DisinfectFlg
		
		SET @EndSite  = ''
		SET @Miles = 0
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
		    SET @StartSite = @SourceContactID
		    IF @EndSite<>''
		       SET @NewMiles=(Select isnull(OneWayMiles,0) from vcfContactMilesMatrix 
						where SourceSite=@StartSite and DestSite=@EndSite)
			IF @NewMiles>0 BEGIN Set @Miles=@Miles+@NewMiles END
			IF @TrailerWashFlg<>0 BEGIN SET @Wash=1 END
			IF @DisinfectFlg<>0 BEGIN SET @Disinfect=1 END
		    SET @EndSite = @SourceContactID
		
		    FETCH NEXT FROM MilesCursor INTO @SourceContactID,@LoadTime, @TrailerWashFlg, @DisinfectFlg
		END
		
		Set @Miles=Ceiling(@Miles)
		IF @Miles < 75 BEGIN SET @Miles = 75 END
		
		CLOSE MilesCursor
		DEALLOCATE MilesCursor
				
	END
ELSE
	BEGIN SET @Miles=0 END
RETURN @Miles 
END


GO
GRANT CONTROL
    ON OBJECT::[dbo].[getRateMiles] TO [MSDSL]
    AS [dbo];


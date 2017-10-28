CREATE Procedure pb_FlowBoard @RI_ID smallint as 

	
	--use variable to hold the report run date (for determining the active manager)
	Declare @RI_Where VARCHAR(255), @Search VARCHAR(255), @Pos SMALLINT,
		@RptDate smalldatetime, @EndOfWeekDate smalldatetime
	Select @RI_Where = LTRIM(RTRIM(RI_Where)), @RptDate = ReportDate from RptRunTime Where RI_ID = @RI_ID
	SELECT @EndOfWeekDate = @RptDate + 6
	
	--clear the work table (just in case)
    	Delete from WrkFlowBoard Where RI_ID = @RI_ID

	--insert the Data and RI_ID information into the work table (most comes from this join
	Insert Into WrkFlowBoard (MovementDate, SourceContactID, SourceBarnNbr, SourcePigGroupID, EstimatedQty, DestContactID, DestPigGroupID, DestBarnNbr, RI_ID)
	Select Distinct MovementDate, SourceContactID, SourceBarnNbr, SourcePigGroupID, EstimatedQty, DestContactID, DestPigGroupID, DestBarnNbr, @RI_ID 
	from cftPM
	WHERE MovementDate BETWEEN @RptDate AND @EndOfWeekDate
	--AND PMTypeID = '02'

	-- Now loop through each of the packer appended previously and calc daily totals
/**	DECLARE @PackerID varchar(6)
	DECLARE packer_cursor CURSOR FOR 
	    SELECT PackerContactID
	    FROM WrkMarketTotals
	    WHERE RI_ID = @RI_ID
	    ORDER BY PackerContactID
	
	OPEN packer_cursor
	
	FETCH NEXT FROM packer_cursor 
	INTO @PackerID
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
	   -- Fetch Sunday Total
	 	UPDATE WrkMarketTotals
			SET Day0Date = @RptDate, Day0TotalQty = Sum(ActualQty),
			Day0EstLbs = Avg(EstimatedWgt), Day0ActLbs = Avg(ActualWgt)
			FROM cftPM
			WHERE PkrContactID = @PackerID
			AND MovementDate = @RptDate
			AND RI_ID = @RI_ID

	   -- Fetch Monday Total
	 	UPDATE WrkMarketTotals
			SET Day0Date = @RptDate, Day0TotalQty = Sum(ActualQty),
			Day0EstLbs = Avg(EstimatedWgt), Day0ActLbs = Avg(ActualWgt)
			FROM cftPM
			WHERE PkrContactID = @PackerID
			AND MovementDate = @RptDate + 1
			AND RI_ID = @RI_ID
			   
	   -- Fetch Tuesday Total
	
	   -- Fetch Wednesday Total	

	   -- Get the next packer.
	   FETCH NEXT FROM packer_cursor 
	   INTO @PackerID
	END

	CLOSE packer_cursor
	DEALLOCATE packer_cursor **/

	--add ri_id as a filter in the report where clause
	SELECT @Search = '(RI_ID = ' + RTRIM(CONVERT(VARCHAR(6),@RI_ID)) + ')'
	
	SELECT @Pos = PATINDEX('%' + @Search + '%', @RI_Where)
	
	UPDATE RptRunTime SET RI_Where = CASE
		WHEN @RI_Where IS NULL OR DATALENGTH(@RI_Where) <= 0
			THEN @Search
		WHEN @Pos <= 0
			THEN @Search + ' AND (' + @RI_WHERE + ')'
	END
	WHERE RI_ID = @RI_ID



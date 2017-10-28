





CREATE         Procedure pb_Market @RI_ID smallint as 

	--Declare @RI_ID smallint
	--SET @RI_ID = 99	

	--use variable to hold the report run date (for determining the active manager)
	Declare @RI_Where VARCHAR(255), @Search VARCHAR(255), @Pos SMALLINT,
		@RptDate smalldatetime, @EndOfWeekDate smalldatetime, @CpnyID varchar(3)
	Select  @RI_Where = LTRIM(RTRIM(RI_Where)), @RptDate = ReportDate, @CpnyID = CpnyID from RptRunTime Where RI_ID = @RI_ID
		
	
	--SET @RptDate = '4/3/2005'
	--SET @CpnyID = 'CFF'
        SELECT @EndOfWeekDate = @RptDate + 6

	
		
	--clear the work table (just in case)
    	Delete from WrkMarketTotals Where RI_ID = @RI_ID

	--insert the packerID and RI_ID information into the work table (most comes from this join
	Insert Into WrkMarketTotals (PackerContactID, RI_ID)
	Select Distinct c.ContactID, @RI_ID 
	FROM cftContact c
	INNER JOIN cftPacker p on p.ContactID = c.ContactID
	INNER JOIN cftPM pm on pm.DestContactID = p.ContactID
	INNER JOIN cftMarketSaleType mst on 
   		mst.MarketSaleTypeID = pm.MarketSaleTypeID
	WHERE pm.MovementDate BETWEEN @RptDate AND @EndOfWeekDate
	AND PMTypeID = '02' AND Highlight<>255
	AND pm.CpnyID = @CpnyID

	-- Now loop through each of the packer appended previously and calc daily totals
	DECLARE @PackerID varchar(6)
	DECLARE packer_cursor CURSOR FOR 
	    SELECT Distinct PackerContactID
	    FROM WrkMarketTotals
	    WHERE RI_ID = @RI_ID
	    ORDER BY PackerContactID
	
	OPEN packer_cursor
	
	FETCH NEXT FROM packer_cursor 
	INTO @PackerID

	WHILE @@FETCH_STATUS = 0
	BEGIN
	   -- Fetch Sunday Total
		Insert into WrkMarketTotals(
			RI_ID,PackerContactID,
			DayTotalQty,DayEstLbs,DayEstLbsCount,DayActLbs,DayActLbsCount,
			Day0Date,Day0TotalQty,Day0EstLbs,Day0EstLbsCount,Day0ActLbs,Day0ActLbsCount)
	    Select  @RI_ID,@PackerID,ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END,
				@RptDate, ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END

		  	FROM cftPM
			WHERE DestContactID = @PackerID
			AND MovementDate = @RptDate
			AND PMTypeID = '02' AND Highlight<>255
			AND CpnyID = @CpnyID
			AND ActualQty>0
                
           -- Fetch Monday Total
	    Insert into WrkMarketTotals(
			RI_ID,PackerContactID,
			DayTotalQty,DayEstLbs,DayEstLbsCount,DayActLbs,DayActLbsCount,
			Day1Date,Day1TotalQty,Day1EstLbs,Day1EstLbsCount,Day1ActLbs,Day1ActLbsCount)
	    Select  @RI_ID,@PackerID, ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END,
				@RptDate+1,ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END
		  	FROM cftPM
			WHERE DestContactID = @PackerID
			AND MovementDate = @RptDate+1
			AND PMTypeID = '02' AND Highlight<>255
			AND CpnyID = @CpnyID
			AND ActualQty>0

	   -- Fetch Tuesday Total
	   	Insert into WrkMarketTotals(
			RI_ID,PackerContactID,
			DayTotalQty,DayEstLbs,DayEstLbsCount,DayActLbs,DayActLbsCount,
			Day2Date,Day2TotalQty,Day2EstLbs,Day2EstLbsCount,Day2ActLbs,Day2ActLbsCount)
	    Select  @RI_ID,@PackerID, ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END,
				@RptDate+2,ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END

		  	FROM cftPM
			WHERE DestContactID = @PackerID
			AND MovementDate = @RptDate+2
			AND PMTypeID = '02' AND Highlight<>255
			AND CpnyID = @CpnyID
			AND ActualQty>0

	   -- Fetch Wednesday Total	
		Insert into WrkMarketTotals(
			RI_ID,PackerContactID,
			DayTotalQty,DayEstLbs,DayEstLbsCount,DayActLbs,DayActLbsCount,
			Day3Date,Day3TotalQty,Day3EstLbs,Day3EstLbsCount,Day3ActLbs,Day3ActLbsCount)
	    Select  @RI_ID,@PackerID, ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END,
				@RptDate+3,ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END

		  	FROM cftPM
			WHERE DestContactID = @PackerID
			AND MovementDate = @RptDate+3
			AND PMTypeID = '02' AND Highlight<>255
			AND CpnyID = @CpnyID
			AND ActualQty>0
	
	   -- Fetch Thursday Total	
		Insert into WrkMarketTotals(
			RI_ID,PackerContactID,
			DayTotalQty,DayEstLbs,DayEstLbsCount,DayActLbs,DayActLbsCount,
			Day4Date,Day4TotalQty,Day4EstLbs,Day4EstLbsCount,Day4ActLbs,Day4ActLbsCount)
	    Select  @RI_ID,@PackerID, ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END,
				@RptDate+4,ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END
		  	FROM cftPM
			WHERE DestContactID = @PackerID
			AND MovementDate = @RptDate+4
			AND PMTypeID = '02' AND Highlight<>255
			AND CpnyID = @CpnyID
			AND ActualQty>0

	   -- Fetch Friday Total	
		Insert into WrkMarketTotals(
			RI_ID,PackerContactID,
		DayTotalQty,DayEstLbs,DayEstLbsCount,DayActLbs,DayActLbsCount,
		Day5Date,Day5TotalQty,Day5EstLbs,Day5EstLbsCount,Day5ActLbs,Day5ActLbsCount)
	    Select  @RI_ID,@PackerID, ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END,
				@RptDate+5,ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END

		  	FROM cftPM
			WHERE DestContactID = @PackerID
			AND MovementDate = @RptDate+5
			AND PMTypeID = '02' AND Highlight<>255
			AND CpnyID = @CpnyID
			AND ActualQty>0

	   -- Fetch Saturday Total	
		Insert into WrkMarketTotals(
			RI_ID,PackerContactID,
			DayTotalQty,DayEstLbs,DayEstLbsCount,DayActLbs,DayActLbsCount,
			Day6Date,Day6TotalQty,Day6EstLbs,Day6EstLbsCount,Day6ActLbs,Day6ActLbsCount)
	    Select  @RI_ID,@PackerID,
				ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END,
				@RptDate+6, ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END

		  	FROM cftPM
			WHERE DestContactID = @PackerID
			AND MovementDate = @RptDate+6
			AND PMTypeID = '02' AND Highlight<>255
			AND CpnyID = @CpnyID
			AND ActualQty>0

	   -- Get the next packer.
	   FETCH NEXT FROM packer_cursor 
	   INTO @PackerID
	END

	CLOSE packer_cursor
	DEALLOCATE packer_cursor

--Insert Non-Markets
 -- Fetch Sunday Total
		Insert into WrkMarketTotals(
			RI_ID,PackerContactID,
			DayTotalQty,DayEstLbs,DayEstLbsCount,DayActLbs,DayActLbsCount,
			Day0Date,Day0TotalQty,Day0EstLbs,Day0EstLbsCount,Day0ActLbs,Day0ActLbsCount)
	    Select  @RI_ID,'NON',ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END,
				@RptDate, ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END

		  	FROM cftPM pm LEFT JOIN cftMarketSaleType m on pm.MarketSaleTypeID=m.MarketSaleTypeID
			WHERE m.MarketTotalType='NON'
			AND MovementDate = @RptDate
			AND PMTypeID = '02' AND Highlight<>255 
			AND CpnyID = @CpnyID
			AND ActualQty>0
                
           -- Fetch Monday Total
	    Insert into WrkMarketTotals(
			RI_ID,PackerContactID,
			DayTotalQty,DayEstLbs,DayEstLbsCount,DayActLbs,DayActLbsCount,
			Day1Date,Day1TotalQty,Day1EstLbs,Day1EstLbsCount,Day1ActLbs,Day1ActLbsCount)
	    Select  @RI_ID,'NON', ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END,
				@RptDate+1,ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END
		  	FROM cftPM pm LEFT JOIN cftMarketSaleType m on pm.MarketSaleTypeID=m.MarketSaleTypeID
			WHERE m.MarketTotalType='NON'
			
			AND MovementDate = @RptDate+1
			AND PMTypeID = '02' AND Highlight<>255
			AND CpnyID = @CpnyID
			AND ActualQty>0

	   -- Fetch Tuesday Total
	   	Insert into WrkMarketTotals(
			RI_ID,PackerContactID,
			DayTotalQty,DayEstLbs,DayEstLbsCount,DayActLbs,DayActLbsCount,
			Day2Date,Day2TotalQty,Day2EstLbs,Day2EstLbsCount,Day2ActLbs,Day2ActLbsCount)
	    Select  @RI_ID,'NON', ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END,
				@RptDate+2,ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END

		  	FROM cftPM pm LEFT JOIN cftMarketSaleType m on pm.MarketSaleTypeID=m.MarketSaleTypeID
			WHERE m.MarketTotalType='NON'
			
			AND MovementDate = @RptDate+2
			AND PMTypeID = '02' AND Highlight<>255
			AND CpnyID = @CpnyID
			AND ActualQty>0

	   -- Fetch Wednesday Total	
		Insert into WrkMarketTotals(
			RI_ID,PackerContactID,
			DayTotalQty,DayEstLbs,DayEstLbsCount,DayActLbs,DayActLbsCount,
			Day3Date,Day3TotalQty,Day3EstLbs,Day3EstLbsCount,Day3ActLbs,Day3ActLbsCount)
	    Select  @RI_ID,'NON', ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END,
				@RptDate+3,ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END
		  	FROM cftPM pm LEFT JOIN cftMarketSaleType m on pm.MarketSaleTypeID=m.MarketSaleTypeID
			WHERE m.MarketTotalType='NON'
			
			AND MovementDate = @RptDate+3
			AND PMTypeID = '02' AND Highlight<>255
			AND CpnyID = @CpnyID
			AND ActualQty>0
	
	   -- Fetch Thursday Total	
		Insert into WrkMarketTotals(
			RI_ID,PackerContactID,
			DayTotalQty,DayEstLbs,DayEstLbsCount,DayActLbs,DayActLbsCount,
			Day4Date,Day4TotalQty,Day4EstLbs,Day4EstLbsCount,Day4ActLbs,Day4ActLbsCount)
	    Select  @RI_ID,'NON', ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END,
				@RptDate+4,ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END
		  	FROM cftPM pm LEFT JOIN cftMarketSaleType m on pm.MarketSaleTypeID=m.MarketSaleTypeID
			WHERE m.MarketTotalType='NON'
			
			AND MovementDate = @RptDate+4
			AND PMTypeID = '02' AND Highlight<>255
			AND CpnyID = @CpnyID
			AND ActualQty>0

	   -- Fetch Friday Total	
		Insert into WrkMarketTotals(
			RI_ID,PackerContactID,
		DayTotalQty,DayEstLbs,DayEstLbsCount,DayActLbs,DayActLbsCount,
		Day5Date,Day5TotalQty,Day5EstLbs,Day5EstLbsCount,Day5ActLbs,Day5ActLbsCount)
	    Select  @RI_ID,'NON', ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END,
				@RptDate+5,ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END
		  	FROM cftPM pm LEFT JOIN cftMarketSaleType m on pm.MarketSaleTypeID=m.MarketSaleTypeID
			WHERE m.MarketTotalType='NON'
			
			AND MovementDate = @RptDate+5
			AND PMTypeID = '02' AND Highlight<>255
			AND CpnyID = @CpnyID
			AND ActualQty>0

	   -- Fetch Saturday Total	
		Insert into WrkMarketTotals(
			RI_ID,PackerContactID,
			DayTotalQty,DayEstLbs,DayEstLbsCount,DayActLbs,DayActLbsCount,
			Day6Date,Day6TotalQty,Day6EstLbs,Day6EstLbsCount,Day6ActLbs,Day6ActLbsCount)
	    Select  @RI_ID,'NON',
				ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END,
				@RptDate+6, ActualQty ,EstimatedWgt,CASE WHEN EstimatedWgt > 0 THEN 1 ELSE 0 END,
				ActualWgt,CASE WHEN ActualWgt > 0 THEN 1 ELSE 0 END
		  	FROM cftPM pm LEFT JOIN cftMarketSaleType m on pm.MarketSaleTypeID=m.MarketSaleTypeID
			WHERE m.MarketTotalType='NON'
			AND MovementDate = @RptDate+6
			AND PMTypeID = '02' AND Highlight<>255
			AND CpnyID = @CpnyID
			AND ActualQty>0


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












GO
GRANT CONTROL
    ON OBJECT::[dbo].[pb_Market] TO [MSDSL]
    AS [dbo];


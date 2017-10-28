




CREATE      Procedure dbo.pb_MarketTotalsSub @RptDate smalldatetime, @CpnyID varchar(3)
 as 

	
	--use variable to hold the report run date (for determining the active manager)
	--Declare @CpnyID varchar(3), @EndOfWeekDate smalldatetime
	--Select @RI_Where = LTRIM(RTRIM(RI_Where)), @RptDate = ReportDate from RptRunTime Where RI_ID = @RI_ID
	
	--Declare @RptDate smalldatetime
	--SET @RptDate = '3/27/2005'
	--SET @CpnyID = 'CFF'
        --SELECT @EndOfWeekDate = @RptDate + 6
    
SELECT max(@RptDate) As Day0Date,
   (Select Sum(pm1.ActualQty) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day0Qty,
   (Select Sum(Cast(pm1.EstimatedWgt As smallint)) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day0EstLbs,
   (Select Sum(pm1.ActualWgt) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day0ActLbs,
   (Select Count(CASE WHEN (Cast(pm1.EstimatedWgt As smallint) > 0) THEN 1 ELSE null END) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day0EstLbsCount,
   (Select Count(CASE WHEN (Cast(pm1.ActualWgt As smallint) > 0) THEN 1 ELSE null END) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day0ActLbsCount,

    -- Day 1
   (SELECT max(@RptDate + 1)) As Day1Date,
   (Select Sum(pm1.ActualQty) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 1
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day1Qty,
   (Select Sum(Cast(pm1.EstimatedWgt As smallint)) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 1
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day1EstLbs,
   (Select Sum(pm1.ActualWgt) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 1
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day1ActLbs,
   (Select Count(CASE WHEN (Cast(pm1.EstimatedWgt As smallint) > 0) THEN 1 ELSE null END) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 1
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day1EstLbsCount,
   (Select Count(CASE WHEN (Cast(pm1.ActualWgt As smallint) > 0) THEN 1 ELSE null END) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 1
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day1ActLbsCount,

    -- Day 2
   (SELECT max(@RptDate + 2)) As Day2Date,
   (Select Sum(pm1.ActualQty) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 2
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day2Qty,
   (Select Sum(Cast(pm1.EstimatedWgt As smallint)) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 2
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day2EstLbs,
   (Select Sum(pm1.ActualWgt) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 2
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day2ActLbs,
   (Select Count(CASE WHEN (Cast(pm1.EstimatedWgt As smallint) > 0) THEN 1 ELSE null END) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 2
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day2EstLbsCount,
   (Select Count(CASE WHEN (Cast(pm1.ActualWgt As smallint) > 0) THEN 1 ELSE null END) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 2
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day2ActLbsCount,

-- Day 3
   (SELECT max(@RptDate + 3)) As Day3Date,
   (Select Sum(pm1.ActualQty) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 3
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day3Qty,
   (Select Sum(Cast(pm1.EstimatedWgt As smallint)) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 3
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day3EstLbs,
   (Select Sum(pm1.ActualWgt) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 3
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day3ActLbs,
   (Select Count(CASE WHEN (Cast(pm1.EstimatedWgt As smallint) > 0) THEN 1 ELSE null END) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 3
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day3EstLbsCount,
   (Select Count(CASE WHEN (Cast(pm1.ActualWgt As smallint) > 0) THEN 1 ELSE null END) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 3
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day3ActLbsCount,
    
-- Day 4
   (SELECT max(@RptDate + 4)) As Day4Date,
   (Select Sum(pm1.ActualQty) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 4	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day4Qty,
   (Select Sum(Cast(pm1.EstimatedWgt As smallint)) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 4
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day4EstLbs,
   (Select Sum(pm1.ActualWgt) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 4
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day4ActLbs,
   (Select Count(CASE WHEN (Cast(pm1.EstimatedWgt As smallint) > 0) THEN 1 ELSE null END) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 4
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day4EstLbsCount,
   (Select Count(CASE WHEN (Cast(pm1.ActualWgt As smallint) > 0) THEN 1 ELSE null END) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 4
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day4ActLbsCount,

-- Day 5
   (SELECT max(@RptDate + 5)) As Day5Date,
   (Select Sum(pm1.ActualQty) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 5
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day5Qty,
   (Select Sum(Cast(pm1.EstimatedWgt As smallint)) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 5
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day5EstLbs,
   (Select Sum(pm1.ActualWgt) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 5
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day5ActLbs,
   (Select Count(CASE WHEN (Cast(pm1.EstimatedWgt As smallint) > 0) THEN 1 ELSE null END) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 5
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day5EstLbsCount,
   (Select Count(CASE WHEN (Cast(pm1.ActualWgt As smallint) > 0) THEN 1 ELSE null END) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 5
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day5ActLbsCount,

-- Day 6
   (SELECT max(@RptDate + 6)) As Day6Date,
   (Select Sum(pm1.ActualQty) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 6
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day6Qty,
   (Select Sum(Cast(pm1.EstimatedWgt As smallint)) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 6
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day6EstLbs,
   (Select Sum(pm1.ActualWgt) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 6
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day6ActLbs,
   (Select Count(CASE WHEN (Cast(pm1.EstimatedWgt As smallint) > 0) THEN 1 ELSE null END) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 6
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day6EstLbsCount,
   (Select Count(CASE WHEN (Cast(pm1.ActualWgt As smallint) > 0) THEN 1 ELSE null END) FROM cftPM pm1
	JOIN cftMarketSaleType mst ON mst.MarketSaleTypeID = pm1.MarketSaleTypeID
	Where pm1.MovementDate = @RptDate + 6
	AND CpnyID = @CpnyID
	AND PMTypeID = '02'
	and mst.MarketTotalType = 'NON')
	As Day6ActLbsCount


   
    








GO
GRANT CONTROL
    ON OBJECT::[dbo].[pb_MarketTotalsSub] TO [MSDSL]
    AS [dbo];


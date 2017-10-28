 CREATE PROCEDURE ADG_GetSlsPerPerformance
	@slsperid  varchar(10),
	@fiscalyear  integer
AS

	declare @cogs00 float
	declare @cogs01 float
	declare @cogs02 float
	declare @cogs03 float
	declare @cogs04 float
	declare @cogs05 float
	declare @cogs06 float
	declare @cogs07 float
	declare @cogs08 float
	declare @cogs09 float
	declare @cogs10 float
	declare @cogs11 float
	declare @cogs12 float

	declare @sell00 float
	declare @sell01 float
	declare @sell02 float
	declare @sell03 float
	declare @sell04 float
	declare @sell05 float
	declare @sell06 float
	declare @sell07 float
	declare @sell08 float
	declare @sell09 float
	declare @sell10 float
	declare @sell11 float
	declare @sell12 float

	declare @fiscalYearStr varchar(4)

	-- Store the fiscal year as a string
	select @fiscalYearStr = convert(varchar(4),@fiscalYear)

	-- Create a the temp table that will hold the results of this procedure
	create table #tmp_slsperperf (
		Period varchar(6) NOT NULL,
		BookingsQuota float NULL,
		BookingsActual float NULL,
		BookingsPct float NULL,
		SalesQuota float NULL,
		SalesActual float NULL,
		SalesPct float NULL,
		SalesGPPct float NULL,
		SalesCogs float NULL
	)


	-- Get salesperson history data for the specified fiscalyear
	select
		@cogs00 = PtdCOGS00,  @cogs01 = PtdCOGS01,  @cogs02 = PtdCOGS02,
		@cogs03 = PtdCOGS03,  @cogs04 = PtdCOGS04,  @cogs05 = PtdCOGS05,
		@cogs06 = PtdCOGS06,  @cogs07 = PtdCOGS07,  @cogs07 = PtdCOGS07,
		@cogs09 = PtdCOGS09,  @cogs10 = PtdCOGS10,  @cogs11 = PtdCOGS11,  @cogs12 = PtdCOGS12,
		@sell00 = PtdSls00,   @sell01 = PtdSls01,   @sell02 = PtdSls02,
		@sell03 = PtdSls03,   @sell04 = PtdSls04,   @sell05 = PtdSls05,
		@sell06 = PtdSls06,   @sell07 = PtdSls07,   @sell08 = PtdSls08,
		@sell09 = PtdSls09,   @sell10 = PtdSls10,   @sell11 = PtdSls11,   @sell12 = PtdSls12
	from
		slsperhist
	where
		fiscyr = @fiscalYearStr
	and
		slsperid = @slsperid

	-- For each period in this fiscal year, insert the corresponding history data.
	insert #tmp_slsperperf( Period, SalesCogs, SalesActual ) values ( @fiscalYearStr + '01', @cogs00, @sell00 )
	insert #tmp_slsperperf( Period, SalesCogs, SalesActual ) values ( @fiscalYearStr + '02', @cogs01, @sell01 )
	insert #tmp_slsperperf( Period, SalesCogs, SalesActual ) values ( @fiscalYearStr + '03', @cogs02, @sell02 )
	insert #tmp_slsperperf( Period, SalesCogs, SalesActual ) values ( @fiscalYearStr + '04', @cogs03, @sell03 )
	insert #tmp_slsperperf( Period, SalesCogs, SalesActual ) values ( @fiscalYearStr + '05', @cogs04, @sell04 )
	insert #tmp_slsperperf( Period, SalesCogs, SalesActual ) values ( @fiscalYearStr + '06', @cogs05, @sell05 )
	insert #tmp_slsperperf( Period, SalesCogs, SalesActual ) values ( @fiscalYearStr + '07', @cogs06, @sell06 )
	insert #tmp_slsperperf( Period, SalesCogs, SalesActual ) values ( @fiscalYearStr + '08', @cogs07, @sell07 )
	insert #tmp_slsperperf( Period, SalesCogs, SalesActual ) values ( @fiscalYearStr + '09', @cogs08, @sell08 )
	insert #tmp_slsperperf( Period, SalesCogs, SalesActual ) values ( @fiscalYearStr + '10', @cogs09, @sell09 )
	insert #tmp_slsperperf( Period, SalesCogs, SalesActual ) values ( @fiscalYearStr + '11', @cogs10, @sell10 )
	insert #tmp_slsperperf( Period, SalesCogs, SalesActual ) values ( @fiscalYearStr + '12', @cogs11, @sell11 )
	insert #tmp_slsperperf( Period, SalesCogs, SalesActual ) values ( @fiscalYearStr + '13', @cogs12, @sell12 )

	-- Update quota columns using data from slsperquota.
	update
		#tmp_slsperperf
	set
		#tmp_slsperperf.BookingsQuota = q.BookQuota,
		#tmp_slsperperf.SalesQuota = q.SalesQuota,
		#tmp_slsperperf.BookingsActual = q.Bookings
	from
		#tmp_slsperperf,
		slsperquota q
	where
		q.slsperid = @slsperid
	and
		q.pernbr = #tmp_slsperperf.period

	-- Return the results.
	select * from #tmp_slsperperf

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



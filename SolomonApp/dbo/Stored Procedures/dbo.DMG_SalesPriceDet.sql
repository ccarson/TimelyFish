 create procedure DMG_SalesPriceDet
	@PriceCat varchar(2),
	@SelectFld1 varchar(30),
	@SelectFld2 varchar(30),
	@CuryID varchar(4),
	@SiteID varchar(10),
	@CatalogNbr varchar(15),
	@SlsUnit varchar(6),
	@Quantity float,
	@OrdDate smalldatetime,
	@SlsPrcID varchar(15),
	@DiscPrcMthd varchar(1) OUTPUT,
	@DiscPrcTyp varchar(1) OUTPUT,
	@QtyBreak float OUTPUT,
	@DiscPrice float OUTPUT,
	@DiscPct float OUTPUT,
	@ChainDisc varchar(15) OUTPUT,
	@StartDate smalldatetime OUTPUT,
	@EndDate smalldatetime OUTPUT,
	@SlsPrcIDUsed varchar(15) OUTPUT
as
	declare @CatalogNbrLoc varchar(15)
	declare @RowCount smallint

	if @CatalogNbr = ''
		Set @CatalogNbrLoc = '%'
	else
		Set @CatalogNbrLoc = @CatalogNbr

	if @SlsPrcID <> '' begin

		select top 1
			@DiscPrcMthd	= h.DiscPrcMthd,
			@DiscPrcTyp	= h.DiscPrcTyp,
			@QtyBreak	= d.QtyBreak,
			@DiscPrice	= d.DiscPrice,
			@DiscPct	= d.DiscPct,
			@ChainDisc	= d.S4Future01,
			@StartDate	= d.StartDate,
			@EndDate	= d.EndDate,
			@SlsPrcIDUsed	= h.SlsPrcID
		from	SlsPrc h,
			SlsPrcDet d
		where	h.SlsPrcID = d.SlsPrcID
		and	h.SlsPrcID = @SlsPrcID
		and	h.PriceCat = @PriceCat
		and	h.SelectFld1 = @SelectFld1
		and	h.SelectFld2 = @SelectFld2
		and	h.CuryID = @CuryID
		and	h.SiteID = @SiteID
		and	d.SlsUnit = @SlsUnit
		and	CatalogNbr like @CatalogNbrLoc
		and	d.QtyBreak <= @Quantity
		and	(h.DiscPrcTyp = 'P' and d.StartDate <= @OrdDate and @OrdDate <= d.EndDate
		or	h.DiscPrcTyp <> 'P')
		order by h.DiscPrcTyp, d.QtyBreak DESC
	end
	else begin

		select top 1
			@DiscPrcMthd	= h.DiscPrcMthd,
			@DiscPrcTyp	= h.DiscPrcTyp,
			@QtyBreak	= d.QtyBreak,
			@DiscPrice	= d.DiscPrice,
			@DiscPct	= d.DiscPct,
			@ChainDisc	= d.S4Future01,
			@StartDate	= d.StartDate,
			@EndDate	= d.EndDate,
			@SlsPrcIDUsed	= h.SlsPrcID
		from	SlsPrc h,
			SlsPrcDet d
		where	h.SlsPrcID = d.SlsPrcID
		and	h.PriceCat = @PriceCat
		and	h.SelectFld1 = @SelectFld1
		and	h.SelectFld2 = @SelectFld2
		and	h.CuryID = @CuryID
		and	h.SiteID = @SiteID
		and	d.SlsUnit = @SlsUnit
		and	CatalogNbr like @CatalogNbrLoc
		and	d.QtyBreak <= @Quantity
		and	(h.DiscPrcTyp = 'P' and d.StartDate <= @OrdDate and @OrdDate <= d.EndDate
		or	h.DiscPrcTyp <> 'P')
		order by h.DiscPrcTyp, d.QtyBreak DESC
	end

	Set @RowCount = @@ROWCOUNT

	return @RowCount



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SalesPriceDet] TO [MSDSL]
    AS [dbo];


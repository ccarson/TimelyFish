 create procedure ADG_SlsPrc3

	@PriceCat varchar(2),
	@SelectFld1 varchar(30),
	@SelectFld2 varchar(30),
	@CuryID varchar(4),
	@SiteID varchar(10),
	@CatalogNbr varchar(15)
as
	select	*
	from	SlsPrc
	where	PriceCat = @PriceCat
	and	SelectFld1 = @SelectFld1
	and	SelectFld2 = @SelectFld2
	and	CuryID = @CuryID
	and	SiteID = @SiteID
	and	CatalogNbr like @CatalogNbr
	order by DiscPrcTyp, SlsPrcID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SlsPrc3] TO [MSDSL]
    AS [dbo];


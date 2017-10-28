 CREATE Procedure wc_PriceItem(
    @ShopperID      varchar(32),
    @CustID         varchar(15),
    @InvtID         varchar(30),
    @SiteID         varchar(10),
    @QtyOrd         decimal(25,9),
    @UnitDesc       varchar(6)
)As
    DECLARE     @Behavior         varchar(4)
    DECLARE     @BaseCuryID       varchar(4)
    DECLARE     @CatalogNbr       varchar(15)
    DECLARE     @SlsPrcID         varchar(15)
    DECLARE     @CnvFact          decimal(25,9)
    DECLARE     @UnitMultDiv      varchar(1)
    DECLARE     @CustPriceClassID varchar(6)
    DECLARE     @InvtPriceClassID varchar(6)
    DECLARE     @OrdDate          smalldatetime
    DECLARE     @CuryID           varchar(4)
    DECLARE     @CuryRate         decimal(25,9)
    DECLARE     @CuryMultDiv      varchar(1)
    DECLARE     @CurySlsPrice     decimal(25,9)
    DECLARE     @SlsPrice         decimal(25,9)
    DECLARE     @DiscPct          decimal(25,9)
    DECLARE     @ChainDisc        varchar(15)
    DECLARE     @SlsPrcIDUsed     varchar(15)

    DECLARE     @StkUnit VARCHAR(6)
    DECLARE     @ClassID VARCHAR(6)

    SET @Behavior = 'SO'
    SET @OrdDate  = GETDATE()

    SELECT
        @ClassID = ClassID,
        @StkUnit = StkUnit,
        @InvtPriceClassID = PriceClassID
    FROM
        Inventory
    WHERE
        InvtID = @InvtID

	SELECT
		@BaseCuryID = BaseCuryID
	FROM
		GLSetup (NOLOCK)

    -- If the InvtID is not found then the item is invalid.
    IF @ClassID IS NULL BEGIN
        RETURN
    END

	-- If CustID was not passed, then get the custid for this shopper.
	IF RTRIM(@CustID) = '' BEGIN
		SELECT
			@CustID = ug.CustID
		FROM
			WCUserGroup ug
		JOIN
			WCUser u
			ON
			ug.UserGroupID = u.UserGroupID
		WHERE
			u.ShopperID = @ShopperID
	END

	SELECT @CustPriceClassID = PriceClassID FROM Customer WHERE CustID = @CustID

    exec DMG_GetUnitConversionFactors
        @InvtID,
        @ClassID, -- varchar(6),
        @UnitDesc, -- varchar(6),
        @StkUnit, --    varchar(6),
        @CnvFact OUTPUT, -- float OUTPUT,
        @uNITMultDiv OUTPUT --  varchar(1) OUTPUT

    exec DMG_SalesPrice
        @Behavior,
        @SiteID,
        @QtyOrd,
        @UnitDesc,
        '',       -- @CatalogNbr,
        '',       -- @SlsPrcID,
        @CnvFact,
        @UnitMultDiv,
        @CustID,
        @InvtID,
        @CustPriceClassID,
        @InvtPriceClassID,
        @OrdDate,
        @BaseCuryID,    -- @CuryID,
        1,        -- @CuryRate,
        'M',      -- @CuryMultDiv,
        @CurySlsPrice   OUTPUT,
        @SlsPrice       OUTPUT,
        @DiscPct        OUTPUT,
        @ChainDisc      OUTPUT,
        @SlsPrcIDUsed   OUTPUT


    SELECT
        @CurySlsPrice AS CurySlsPrice,
        @SlsPrice as SlsPrice,
        @DiscPct  as DiscPct,
        @ChainDisc as ChainDisc,
        @SlsPrcIDUsed as SlsPrcIDUsed



GO
GRANT CONTROL
    ON OBJECT::[dbo].[wc_PriceItem] TO [MSDSL]
    AS [dbo];


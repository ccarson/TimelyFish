 CREATE PROCEDURE ED_Check_PickList_Print
	@CpnyID varchar(10),
	@OrdNbr varchar(15),
	@ShipperID varchar(15)
AS
	--DECLARE @TEMPV AS VARCHAR(10)
	--Return Value
	DECLARE @RetValue		char(4)
	DECLARE @Remarks		char(30)

	--Values in SOShipHeader table
	DECLARE @SiteID		char(10)

	--Values in EDSite table
	DECLARE @ConvMeth		char(3)

	--Initialize the return values
	SELECT @RetValue = 'NEXT', @Remarks = ''

	-- Get the SiteID from the SOShipHeader.
	SELECT
		@SiteID	= SiteID
	FROM SOShipHeader
	WHERE CpnyID = @CpnyID AND
		ShipperID = @ShipperID

	-- Get the ConvMeth from the EDSite table
	SELECT
		@ConvMeth	= ConvMeth
	FROM EDSite
	WHERE Trans = '940' AND
		SiteID = @SiteID

	-- If @ConvMeth = 'EPT' then change @RetValue = 'SKIP'

	IF (UPPER(RTRIM(@ConvMeth)) IN ('EPT'))
		SELECT @RetValue = 'SKIP'

	-- Return the answer.
	SELECT @RetValue, @Remarks



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ED_Check_PickList_Print] TO [MSDSL]
    AS [dbo];


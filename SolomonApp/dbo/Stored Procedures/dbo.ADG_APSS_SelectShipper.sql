 CREATE PROCEDURE ADG_APSS_SelectShipper
	@ShipperKey   CHAR(26),
	@ShipperID    CHAR(26),
	@BoxCount     INTEGER,
	@CODAmt       FLOAT,
	@Confirmed    Char( 3),
	@ShipAddr1    CHAR(60),
	@ShipAddr2    CHAR(60),
	@ShipAttn     CHAR(30),
	@ShipCity     CHAR(30),
	@ShipCountry  CHAR( 3),
	@ShipName     CHAR(60),
	@ShipState    CHAR( 3),
	@ShipViaID    CHAR(15),
	@ShipZip      CHAR(10)
AS

    DECLARE @ShipperIDVar VARCHAR(15)
    DECLARE @CpnyIDVar    VARCHAR(10)
    DECLARE @DelimiterPos INT

    -- @ShipperKey should have the form '<CpnyID>.<ShipperID>'.  We need to
    -- parse it into its components.  If no delimiter character is found,

    -- Get the delimiter position.
    SELECT @DelimiterPos = PATINDEX( '%[.]%', @ShipperKey )

    -- Parse the String
    IF ( @DelimiterPos > 0 ) BEGIN
	SELECT 	@ShipperIDVar = SUBSTRING( @ShipperKey, @DelimiterPos + 1, DATALENGTH( @ShipperKey ) - @DelimiterPos ),
		@CpnyIDVar    = SUBSTRING( @ShipperKey, 1, @DelimiterPos - 1 )
    END
    ELSE BEGIN
	SELECT  @ShipperIDVar = NULL,
		@CpnyIDVar    = NULL
    END
	    SELECT
		ShipperKey = null,
		ShipperID = RTRIM(@ShipperKey),
		BoxCount = @BoxCount,
		CODAmt = 	CASE
					WHEN ( SH.TotInvc - SH.TotFrtInvc > 0 ) AND NOT ( Terms.COD IS NULL OR Terms.COD = 0 )
					THEN SH.TotInvc - SH.TotFrtInvc
					ELSE 0
				END,
		Confirmed =  CASE WHEN ( SH.ShippingConfirmed = 0 ) THEN 'N' ELSE 'Y' END,
		SH.ShipAddr1,
		SH.ShipAddr2,
		SH.ShipAttn,
		SH.ShipCity,
		SH.ShipCountry,
		SH.ShipName,
		SH.ShipState,
		SH.ShipViaID,
		SH.ShipZip
    FROM
		SOShipHeader AS SH
    LEFT OUTER JOIN Terms
    ON		SH.termsid   = Terms.termsid
    WHERE	SH.ShipperID = @ShipperIDVar
    AND		SH.CpnyID    = @CpnyIDVar

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



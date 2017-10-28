 CREATE PROCEDURE ADG_SOShipHeader_UpdateInvoice2
	@Ri_id		smallint,
	@Ordnbr		varchar(15),
	@CpnyID 	varchar( 10 ),
	@ShipperID 	varchar( 15 ),
	@InvcNbr	varchar( 15 ) = null,
	@InvcDate	smalldatetime = null,
	@PerPost	varchar( 6 ) = null
AS
	UPDATE 	SOShipHeader
	SET 	InvcNbr = CASE WHEN ShipRegisterID <> ' '
                               THEN InvcNbr
                               ELSE coalesce(@InvcNbr, InvcNbr)
                          END,
               InvcDate = CASE WHEN ShipRegisterID <> ' '
                               THEN InvcDate
                               ELSE coalesce(@InvcDate, InvcDate)
                          END,
               PerPost = CASE WHEN ShipRegisterID <> ' '
                              THEN PerPost
                              ELSE  coalesce(@PerPost, PerPost)
                          END
	WHERE 	CpnyID = @CpnyID
	  AND	ShipperID = @ShipperID

        -- If the Invoice has already been sent to AR, then Delete from SOPrintQue.
	DELETE s
          FROM soprintqueue s JOIN SOShipHeader h
                                ON s.ShipperID = h.ShipperID
                               AND s.CpnyID = h.CpnyID
	 WHERE 	s.ri_id = @Ri_id
	   AND	s.CpnyID like @CpnyID
	   AND	s.OrdNbr like @Ordnbr
	   AND	s.Shipperid like @ShipperID
           AND h.ShipRegisterID <> ' '



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOShipHeader_UpdateInvoice2] TO [MSDSL]
    AS [dbo];


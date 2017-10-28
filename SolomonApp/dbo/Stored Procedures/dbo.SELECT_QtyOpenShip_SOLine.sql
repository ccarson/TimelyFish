
Create Proc SELECT_QtyOpenShip_SOLine @CpnyID varchar(10), @OrdNbr varchar(15), @LineRef varchar(5), @ShipperID VarChar(15)

AS
SELECT l.QtyShip,l.UnitDesc, l.CnvFact, l.UnitMultDiv  
  FROM SOShipLine l WITH(NOLOCK) JOIN SOShipHeader s WITH(NOLOCK)
                                   ON l.ShipperID = s.ShipperID
                                  AND l.CpnyID = s.CpnyID
 WHERE s.cancelled = 0
   AND s.ShippingConfirmed = 0
   AND l.CpnyID = @CpnyID
   AND l.OrdNbr = @OrdNbr
   AND l.OrdLineRef = @LineRef
   AND l.ShipperID <> @ShipperID


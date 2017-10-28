 
 create proc ReBld_ConfShipHeader  AS
 SELECT l.* 
   FROM SOShipHeader s JOIN SOType t
                         ON s.SOTypeID = t.SOTypeID
                        AND s.CpnyID = t.CpnyID
                       JOIN SOShipLine l
                         ON s.ShipperID = l.ShipperID
                        AND s.CpnyID = l.CpnyID
  WHERE s.Status = 'O' 
    AND s.ShippingConfirmed = 1
    AND s.DropShip = 0
    AND s.Cancelled = 0
    AND t.Behavior IN ('SO','INVC','CS','TR','WO','MO','WC')
  Order By l.CpnyID,l.InvtID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ReBld_ConfShipHeader] TO [MSDSL]
    AS [dbo];


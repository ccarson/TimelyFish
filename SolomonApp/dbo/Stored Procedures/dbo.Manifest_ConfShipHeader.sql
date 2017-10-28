 
 create proc Manifest_ConfShipHeader  @CpnyID varchar(10),@ShipperID varchar(15) AS
 SELECT l.* 
   FROM SOShipHeader s WITH(NOLOCK) JOIN SOType t WITH(NOLOCK)
                         ON s.SOTypeID = t.SOTypeID
                        AND s.CpnyID = t.CpnyID
                       JOIN SOShipLine l
                         ON s.ShipperID = l.ShipperID
                        AND s.CpnyID = l.CpnyID
  WHERE s.ShipperID = @ShipperID
    AND s.CpnyID = @CpnyID
    AND s.Status = 'O' 
    AND s.DropShip = 0
    AND s.Cancelled = 0
    AND t.Behavior IN ('SO','INVC','CS','TR','WO','MO','WC')
    
  Order By l.CpnyID,l.InvtID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Manifest_ConfShipHeader] TO [MSDSL]
    AS [dbo];


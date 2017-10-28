
CREATE Proc SELECT_OtherQtyOpenShip @ShipperID	varchar(15), @CpnyID varchar(10), @OrdNbr varchar(15), @OrdLineRef varchar(5),
                       @SchedREf Varchar(5), @ShipToID VarChar(10)

AS 
SELECT SUM(s.QtyOpenShip)		
FROM SOSched s WITH(NOLOCK) JOIN SOShipSched p WITH(NOLOCK)
                 ON s.OrdNbr = p.ordnbr
                AND s.LineRef = p.OrdLineRef
                AND s.SchedRef = p.OrdSchedRef
                AND s.CpnyID = p.CpnyID
WHERE p.ShipperID = @ShipperID 
  AND p.CpnyID = @CpnyID
  AND s.OrdNbr = @OrdNbr
  AND s.LineRef = @OrdLineRef
  AND s.SchedRef <> @SchedRef
  AND s.ShipToID = @ShipToID


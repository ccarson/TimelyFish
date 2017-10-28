
Create Proc SELECT_QtyOpenShip_SOSched @CpnyID varchar(10), @OrdNbr varchar(15), @LineRef varchar(5), @ShipToID VarChar(10), @ShipperID	varchar(15)

AS 
SELECT s.* 
  FROM SOSCHED s JOIN SOShipSched p WITH(NOLOCK)
                 ON s.OrdNbr = p.ordnbr
                AND s.LineRef = p.OrdLineRef
                AND s.SchedRef = p.OrdSchedRef
                AND s.CpnyID = p.CpnyID
 WHERE s.CpnyID = @CpnyID        
   AND s.OrdNbr = @OrdNbr        
   AND s.LineRef = @LineRef      
   AND s.ShipToID = @ShipToID  
   AND p.ShipperID = @ShipperID    
 ORDER BY s.SchedRef Desc



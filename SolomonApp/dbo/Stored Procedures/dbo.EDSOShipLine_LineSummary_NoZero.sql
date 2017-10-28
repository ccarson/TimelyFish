 Create PROCEDURE EDSOShipLine_LineSummary_NoZero @Parm1 varchar( 10 ), @Parm2 varchar( 15 ) AS

SELECT count(*),sum(qtyship)
  FROM SOShipLine
 WHERE CpnyId = @parm1
   AND ShipperId = @Parm2
   AND QtyShip <> 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLine_LineSummary_NoZero] TO [MSDSL]
    AS [dbo];


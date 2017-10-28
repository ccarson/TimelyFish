 CREATE PROCEDURE EDSOShipLine_LineSummary @Parm1 varchar( 10 ), @Parm2 varchar( 15 ) AS
Select count(*),sum(qtyship) From SOShipLine Where CpnyId = @parm1
and ShipperId = @Parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipLine_LineSummary] TO [MSDSL]
    AS [dbo];


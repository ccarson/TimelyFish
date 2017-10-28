 CREATE PROCEDURE SOShipLine_ShipperID_ReNbr @parm1 varchar(10), @parm2 varchar(10) as

update shl
set shl.LineNbr = -32768 + (convert(int, shl.LineRef) - 1) * power(2, case when 16 - ceiling(log(sh.LineCntr)/log(2)) < 8 then 16 - ceiling(log(sh.LineCntr)/log(2)) else 8 end)
from SOShipLine shl
inner join SOShipHeader sh on sh.CpnyID = shl.CpnyID and sh.ShipperID = shl.ShipperID
where sh.CpnyID = @parm1 and sh.ShipperID = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipLine_ShipperID_ReNbr] TO [MSDSL]
    AS [dbo];


 CREATE PROCEDURE SOLine_OrdNbr_ReNbr @parm1 varchar(10), @parm2 varchar(10) as

update sol set
	sol.LineNbr = -32768 + (convert(int, sol.LineRef) - 1) * power(2, case when 16 - ceiling(log(so.LineCntr)/log(2)) < 8 then 16 - ceiling(log(so.LineCntr)/log(2)) else 8 end)
from SOLine sol
inner join SOHeader so on so.CpnyID = sol.CpnyID and so.OrdNbr = sol.OrdNbr
where so.CpnyID = @parm1 and so.OrdNbr = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOLine_OrdNbr_ReNbr] TO [MSDSL]
    AS [dbo];


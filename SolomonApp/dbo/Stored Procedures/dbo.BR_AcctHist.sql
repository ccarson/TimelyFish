 Create Procedure BR_AcctHist
@parm1 char(10),
@parm2 char(10),
@parm3 char(24),
@parm4 char(4),
@parm5 char(10)	-- Added TLG - 4/8/02
as
Select *
from AcctHist
where cpnyid = @parm1 and Acct = @parm2
and Sub = @parm3
and FiscYr = @parm4
and LedgerId = @parm5   	-- Added TLG - 4/8/02
order by cpnyid, Acct, Sub, CuryID, FiscYr, LedgerId  	-- Modified TLG - 4/8/02



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BR_AcctHist] TO [MSDSL]
    AS [dbo];


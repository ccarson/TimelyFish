 Create procedure p08990CheckHistCalc as

Insert into WrkIChk (Custid, Cpnyid, MsgID, OldBal, NewBal, AdjBal, Other)

select v.custid, v.cpnyid, 30, v.CalcCurBal, v.SumNewBals, 0, ''

from vi_08990CompHistToCalc v, currncy c (nolock), glsetup g (nolock)

where Round(v.CalcCurBal, c.decpl) <> Round(v.SumNewBals, c.decpl)
and g.basecuryid = c.curyid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990CheckHistCalc] TO [MSDSL]
    AS [dbo];


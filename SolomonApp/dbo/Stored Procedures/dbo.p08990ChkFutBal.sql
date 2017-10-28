 Create proc p08990ChkFutBal as

Insert into WrkIChk (Custid, Cpnyid, MsgID, OldBal, NewBal, AdjBal, Other)

select v.custid, v.cpnyid, 20, v.OldFutureBal, v.NewFutureBal, 0, ''

from vi_08990CompCustBal v, currncy c (nolock), glsetup g (nolock)
where round(v.NewFutureBal, c.decpl) <> round(v.OldFutureBal, c.decpl)
and c.curyid = g.basecuryid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990ChkFutBal] TO [MSDSL]
    AS [dbo];


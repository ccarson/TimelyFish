 Create proc p08990ChkCurBal as

Insert into WrkIChk (Custid, Cpnyid, MsgID, OldBal, NewBal, AdjBal, Other)

select v.custid, v.cpnyid, 10, v.OldCurrentBal, v.NewCurrentBal, 0, ''

from vi_08990CompCustBal v, currncy c (nolock), glsetup g (nolock)
where round(v.NewCurrentBal, c.decpl) <> round(v.OldCurrentBal, c.decpl)
and c.curyid = g.basecuryid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990ChkCurBal] TO [MSDSL]
    AS [dbo];


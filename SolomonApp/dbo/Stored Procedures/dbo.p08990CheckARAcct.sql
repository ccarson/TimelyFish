 Create procedure p08990CheckARAcct as

Insert into WrkIChk (Custid, Cpnyid, MsgID, OldBal, NewBal, AdjBal, Other)

select c.custid, '', 2, 0, 0, 0, c.aracct

from customer c LEFT OUTER JOIN account a on c.aracct = a.acct

where LTRIM(RTRIM(a.acct)) IS NULL



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990CheckARAcct] TO [MSDSL]
    AS [dbo];


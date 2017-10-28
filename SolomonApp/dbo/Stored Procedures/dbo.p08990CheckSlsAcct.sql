 Create procedure p08990CheckSlsAcct as

Insert into WrkIChk (Custid, Cpnyid, MsgID, OldBal, NewBal, AdjBal, Other)

select c.custid, '', 3, 0, 0, 0, c.slsacct

from customer c LEFT OUTER JOIN account a on c.slsacct = a.acct

where LTRIM(RTRIM(a.acct)) IS NULL



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990CheckSlsAcct] TO [MSDSL]
    AS [dbo];


 Create procedure p08990CheckHist as

Insert into WrkIChk (Custid, Cpnyid, MsgID, OldBal, NewBal, AdjBal, Other)

select b.custid, b.cpnyid, 40, 0, 0, 0, ''

from ar_balances b LEFT OUTER JOIN arhist a on b.custid = a.custid and b.cpnyid = a.cpnyid

where LTRIM(RTRIM(b.cpnyid)) IS NULL



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990CheckHist] TO [MSDSL]
    AS [dbo];


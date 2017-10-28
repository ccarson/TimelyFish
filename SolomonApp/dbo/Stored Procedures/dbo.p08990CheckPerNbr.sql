 Create procedure p08990CheckPerNbr @ARPerNbr varchar (6) as

Insert into WrkIChk (Custid, Cpnyid, MsgID, OldBal, NewBal, AdjBal, Other)

select c.custid, '', 1, 0, 0, 0, c.pernbr

from customer c

where LTRIM(RTRIM(c.pernbr)) <> LTRIM(RTRIM(@ARPerNbr))



GO
GRANT CONTROL
    ON OBJECT::[dbo].[p08990CheckPerNbr] TO [MSDSL]
    AS [dbo];


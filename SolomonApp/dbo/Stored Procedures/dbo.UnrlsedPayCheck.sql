 create proc UnrlsedPayCheck @Parm1 VarChar(10), @Parm2 VarChar(2), @Parm3 VarChar(15) As

Select
batnbr, refnbr
from ARTran where
SiteId = @Parm1 And
CostType = @Parm2 And
Custid = @Parm3 And
DRCR = "U" And
Trantype IN ("PA","CM","PP")



GO
GRANT CONTROL
    ON OBJECT::[dbo].[UnrlsedPayCheck] TO [MSDSL]
    AS [dbo];


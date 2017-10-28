 Create Procedure POReceipt_PONbr_All @parm1 varchar ( 10) As

select distinct po.*
from purchord po
inner join potran t on t.ponbr = po.ponbr
inner join poreceipt r on r.rcptnbr = t.rcptnbr
left join potran t2 on t2.rcptnbr = r.rcptnbr
where t2.ponbr  = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POReceipt_PONbr_All] TO [MSDSL]
    AS [dbo];


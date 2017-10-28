 /****** Object:  Stored Procedure dbo.ARDoc_CpnyID_Class_byrefnbr    Script Date: 4/7/98 12:30:32 PM ******/
Create Procedure ARDoc_CpnyID_Class_byrefnbr @parm1 varchar ( 10), @parm2 varchar ( 15) as
    select * from ardoc where
    cpnyid = @parm1
    and custid = @parm2
    and Rlsed = 1
    and doctype IN ('FI','IN','DM','NC')
    and curydocbal > 0
    order by CustId, Rlsed, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_CpnyID_Class_byrefnbr] TO [MSDSL]
    AS [dbo];


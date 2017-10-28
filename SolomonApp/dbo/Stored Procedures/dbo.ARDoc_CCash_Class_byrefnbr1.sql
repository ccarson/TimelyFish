 /****** Object:  Stored Procedure dbo.ARDoc_CCash_Class_byrefnbr1    Script Date: 4/7/98 12:30:32 PM ******/
Create Procedure ARDoc_CCash_Class_byrefnbr1 @parm1 varchar ( 15) as
    select * from ardoc where
    custid = @parm1
    and Rlsed = 1
    and doctype IN ('FI','IN','DM','NC','CM','PA','PP')
    and curydocbal > 0
    order by CustId, Rlsed, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_CCash_Class_byrefnbr1] TO [MSDSL]
    AS [dbo];


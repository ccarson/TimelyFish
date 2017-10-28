 /****** Object:  Stored Procedure dbo.ARDoc_CCash_Class_byDocType    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_CCash_Class_byDocType @parm1 varchar ( 15) as
    select * from ardoc where
    custid = @parm1
    and Rlsed = 1
    and doctype IN ('FI','IN','DM','NC')
    and curydocbal > 0
    order by CustId, Rlsed, DocType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_CCash_Class_byDocType] TO [MSDSL]
    AS [dbo];


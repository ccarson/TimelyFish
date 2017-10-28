 /****** Object:  Stored Procedure dbo.ARDoc_CustId_Class_bydate    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_CustId_Class_bydate @parm1 varchar ( 15) as
    select * from ardoc where custid = @parm1
    and Rlsed = 1
    and doctype IN ('FI','IN','DM')
    and curydocbal > 0
    order by DueDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_CustId_Class_bydate] TO [MSDSL]
    AS [dbo];


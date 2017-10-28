 /****** Object:  Stored Procedure dbo.ARDoc_CustId_Class_byclass    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_CustId_Class_byclass @parm1 varchar ( 15) as
    select * from ardoc where custid like @parm1
    and doctype IN ('FI', 'IN', 'DM')
    and curydocbal > 0
    and Rlsed = 1
    order by CustId, DocClass, DocDate




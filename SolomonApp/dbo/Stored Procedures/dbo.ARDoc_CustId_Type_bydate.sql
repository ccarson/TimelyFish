 /****** Object:  Stored Procedure dbo.ARDoc_CustId_Type_bydate    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_CustId_Type_bydate @parm1 varchar ( 15), @parm2 varchar ( 2) as
    select * from ardoc where custid = @parm1
    and (doctype = 'PA' or doctype = 'DA' or DocType = @parm2)
    and curydocbal > 0
    and Rlsed = 1
    order by CustId, DocDate




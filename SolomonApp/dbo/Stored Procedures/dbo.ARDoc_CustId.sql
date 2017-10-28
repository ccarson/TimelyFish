 /****** Object:  Stored Procedure dbo.ARDoc_CustId    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_CustId @parm1 varchar ( 15), @parm2 varchar ( 2) as
    select * from ardoc where custid = @parm1
    and (doctype = 'PA' or doctype = @parm2 or doctype = 'DA')
    and curydocbal > 0
    and applbatnbr = ''
    and rlsed = 1
    order by CustId, DocDate




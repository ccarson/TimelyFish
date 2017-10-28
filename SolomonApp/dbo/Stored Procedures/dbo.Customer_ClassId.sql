 /****** Object:  Stored Procedure dbo.Customer_ClassId    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc Customer_ClassId @parm1 varchar ( 6) as
    Select * from Customer where ClassId = @parm1 order by CustId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Customer_ClassId] TO [MSDSL]
    AS [dbo];


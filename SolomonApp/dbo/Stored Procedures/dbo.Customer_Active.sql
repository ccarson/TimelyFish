 /****** Object:  Stored Procedure dbo.Customer_Active    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc Customer_Active @parm1 varchar ( 15) as
    Select * from Customer where CustId like @parm1
    and Status IN ('A', 'O')
    order by CustId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Customer_Active] TO [MSDSL]
    AS [dbo];


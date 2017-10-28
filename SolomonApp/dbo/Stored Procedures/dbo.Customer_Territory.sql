 /****** Object:  Stored Procedure dbo.Customer_Territory    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc Customer_Territory @parm1 varchar (10) as
    Select * from Customer where Territory = @parm1 order by CustId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Customer_Territory] TO [MSDSL]
    AS [dbo];


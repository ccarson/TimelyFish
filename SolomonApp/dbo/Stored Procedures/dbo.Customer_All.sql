 /****** Object:  Stored Procedure dbo.Customer_All    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc Customer_All @parm1 varchar ( 15) as
    Select * from Customer where CustId like @parm1 order by CustId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Customer_All] TO [MSDSL]
    AS [dbo];


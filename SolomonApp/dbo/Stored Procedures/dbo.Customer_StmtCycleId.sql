 /****** Object:  Stored Procedure dbo.Customer_StmtCycleId    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc Customer_StmtCycleId @parm1 varchar ( 2) as
    Select * from Customer where StmtCycleId = @parm1
    order by StmtCycleId, CustId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Customer_StmtCycleId] TO [MSDSL]
    AS [dbo];


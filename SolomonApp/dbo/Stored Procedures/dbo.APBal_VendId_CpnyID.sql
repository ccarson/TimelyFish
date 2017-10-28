 /****** Object:  Stored Procedure dbo.APBal_VendId_CpnyID    Script Date: 4/7/98 12:19:54 PM ******/
Create Proc APBal_VendId_CpnyID @parm1 varchar ( 15), @parm2 varchar ( 15) AS
Select * from AP_Balances where CpnyID = @parm1
        and VendID = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APBal_VendId_CpnyID] TO [MSDSL]
    AS [dbo];


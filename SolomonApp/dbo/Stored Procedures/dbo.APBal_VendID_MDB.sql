 /****** Object:  Stored Procedure dbo.APBal_VendID_MDB    Script Date: 4/7/98 12:19:54 PM ******/
Create Proc APBal_VendID_MDB @parm1 varchar ( 15) AS
Select * from AP_Balances where VendID = @parm1
        order by CpnyID, VendID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APBal_VendID_MDB] TO [MSDSL]
    AS [dbo];


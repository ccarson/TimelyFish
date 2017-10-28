 /****** Object:  Stored Procedure dbo.APBalances_Vend_Cpny    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APBalances_Vend_Cpny @parm1 varchar ( 15), @parm2 varchar ( 10) As
Select * from AP_Balances
where VendID LIKE @parm1
and CpnyId LIKE @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APBalances_Vend_Cpny] TO [MSDSL]
    AS [dbo];


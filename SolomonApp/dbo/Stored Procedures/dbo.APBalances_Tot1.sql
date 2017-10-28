 /****** Object:  Stored Procedure dbo.APBalances_Tot1    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APBalances_Tot1 @parm1 varchar ( 15) As
Select MAX(LastChkDate), MAX(LastVODate), SUM(CurrBal), SUM(FutureBal)
From AP_Balances Where AP_Balances.VendID = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APBalances_Tot1] TO [MSDSL]
    AS [dbo];


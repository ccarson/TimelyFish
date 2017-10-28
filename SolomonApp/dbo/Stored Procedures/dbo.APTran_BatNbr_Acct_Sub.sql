 /****** Object:  Stored Procedure dbo.APTran_BatNbr_Acct_Sub    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure APTran_BatNbr_Acct_Sub @parm1 varchar ( 10) as
Select * from APTran where
BatNbr = @parm1
Order by BatNbr, Acct, Sub



 /****** Object:  Stored Procedure dbo.EC_Get_CashAcct    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure EC_Get_CashAcct @parm1 varchar ( 1) as
Select * From CashAcct
Where AcctType =  @parm1
Order by acctnbr



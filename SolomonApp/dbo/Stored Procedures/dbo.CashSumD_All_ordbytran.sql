 /****** Object:  Stored Procedure dbo.CashSumD_All_ordbytran    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CashSumD_All_ordbytran @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 smalldatetime as
Select * from CashSumD
where cpnyid like @parm1
and bankacct like @parm2
and banksub like @parm3
and TranDate >= @parm4
Order by cpnyid, BankAcct, Banksub, trandate desc, pernbr desc



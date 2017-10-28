 /****** Object:  Stored Procedure dbo.CashSumD_Greater_Than_Date    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CashSumD_Greater_Than_Date @parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 smalldatetime, @parm4 varchar ( 10) as
Select * from CashSumD
where cpnyid like @parm4
and bankacct like @parm1
and banksub like @parm2
and trandate > @parm3
Order by cpnyid, BankAcct, Banksub, trandate



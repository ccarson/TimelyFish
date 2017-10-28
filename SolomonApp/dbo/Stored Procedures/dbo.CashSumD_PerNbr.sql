 /****** Object:  Stored Procedure dbo.CashSumD_PerNbr    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CashSumD_PerNbr @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 smalldatetime, @parm5 varchar ( 6) as
Select * from CashSumD
where cpnyid like @parm1
and bankacct like @parm2
and banksub like @parm3
and trandate = @parm4
and PerNbr = @parm5
Order by cpnyid, BankAcct, Banksub, PerNbr, trandate



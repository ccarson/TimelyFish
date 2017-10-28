 /****** Object:  Stored Procedure dbo.CashSumD_NewPer    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CashSumD_NewPer @parm1 varchar( 10), @parm2 varchar( 10), @parm3 varchar ( 24), @parm4 varchar ( 6) as
Select * from CashSumD
where cpnyid like @parm1
and BankAcct like @parm2
and Banksub like @parm3
and pernbr > @parm4
Order by cpnyid, BankAcct, Banksub, pernbr



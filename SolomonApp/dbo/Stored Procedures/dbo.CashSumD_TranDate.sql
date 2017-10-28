 /****** Object:  Stored Procedure dbo.CashSumD_TranDate    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CashSumD_TranDate @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24), @parm4 smalldatetime, @parm5 varchar ( 6) as
Select * from CashSumD
where cpnyid like @parm1
and bankacct like @parm2
and banksub like @parm3
and trandate = @parm4
and PerNbr like @parm5
Order by CpnyID, BankAcct, Banksub, trandate



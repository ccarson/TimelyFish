 /****** Object:  Stored Procedure dbo.BankTran_Last    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc BankTran_Last @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24) as
Select * from BankTran
where CpnyID like @parm1
and bankacct like @parm2
and banksub like @parm3
order by linenbr desc



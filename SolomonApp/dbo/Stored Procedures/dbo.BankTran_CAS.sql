 /****** Object:  Stored Procedure dbo.BankTran_CAS    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc BankTran_CAS @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4beg smallint, @parm4end smallint as
Select * from BankTran
where CpnyID like @parm1
and bankacct like @parm2
and banksub like @parm3
and linenbr between @parm4beg and @parm4end
order by linenbr



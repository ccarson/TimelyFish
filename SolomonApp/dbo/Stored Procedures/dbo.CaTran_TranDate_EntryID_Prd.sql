 /****** Object:  Stored Procedure dbo.CaTran_TranDate_EntryID_Prd    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CaTran_TranDate_EntryID_Prd @parm1 varchar (10), @parm2 varchar (10), @Parm3 varchar (24), @parm4 smalldatetime, @parm5 varchar (6)  as
Select * from CaTran
where bankcpnyid like @parm1
and bankacct like @parm2
and banksub like @parm3
and trandate = @parm4
and PerPost = @parm5
and rlsed = 1
Order by bankcpnyid, BankAcct, Banksub, trandate, batnbr, EntryID DESC
option (fast 100)



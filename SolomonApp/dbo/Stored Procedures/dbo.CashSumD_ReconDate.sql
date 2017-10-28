 /****** Object:  Stored Procedure dbo.CashSumD_ReconDate    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CashSumD_ReconDate @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 smalldatetime, @parm5 smalldatetime as
Select * from CashSumD
where cpnyid like @parm1
and bankacct like @parm2
and banksub like @parm3
and (trandate > @parm4 and trandate <= @parm5)
Order by cpnyid, BankAcct, Banksub, trandate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CashSumD_ReconDate] TO [MSDSL]
    AS [dbo];


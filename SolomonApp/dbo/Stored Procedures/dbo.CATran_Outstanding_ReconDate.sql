 Create Proc CATran_Outstanding_ReconDate @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24), @parm4 smalldatetime  as
Select * from CATran
where Cpnyid like @parm1
and Bankacct like @parm2
and Banksub like @parm3
and Trandate <= @parm4 and Rlsed = 1 and RcnclStatus = 'O'
Order by Cpnyid, BankAcct, Banksub, TranDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CATran_Outstanding_ReconDate] TO [MSDSL]
    AS [dbo];


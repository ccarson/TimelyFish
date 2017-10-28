 /****** Object:  Stored Procedure dbo.CashAcct_Sub    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CashAcct_Sub @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24) as
    select * from CashAcct
     where cpnyid like @parm1 and bankacct like @parm2
    and banksub like @parm3
    and active =  1
    order by CpnyID, BankAcct, BankSub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CashAcct_Sub] TO [MSDSL]
    AS [dbo];


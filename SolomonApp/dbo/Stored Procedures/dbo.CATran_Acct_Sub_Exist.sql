 /****** Object:  Stored Procedure dbo.CATran_Acct_Sub_Exist    Script Date: 4/7/98 12:49:20 PM ******/
create Proc CATran_Acct_Sub_Exist @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24) as
  Select * from CATran
  Where CpnyID like @parm1 and BankAcct like @parm2 and Banksub like @parm3
 Order by CpnyID, BankAcct, Banksub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CATran_Acct_Sub_Exist] TO [MSDSL]
    AS [dbo];


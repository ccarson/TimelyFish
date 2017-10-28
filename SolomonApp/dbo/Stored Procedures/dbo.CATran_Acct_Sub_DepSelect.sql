 /****** Object:  Stored Procedure dbo.CATran_Acct_Sub_DepSelect    Script Date: 4/7/98 12:49:20 PM ******/
create Proc CATran_Acct_Sub_DepSelect @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24), @parm4 smalldatetime, @parm5 smalldatetime as
  Select * from CATran
  Where CpnyID like @parm1 and BankAcct like @parm2 and Banksub like @parm3
   and ((rcnclstatus = 'O' and TranDate <= @parm5)
   or (rcnclstatus = 'C' and (TranDate <= @parm5 and ClearDate > @parm5)
   or (Trandate <= @parm4 and Trandate > @parm5 and rcnclstatus <> '')))
   and ((catran.drcr = 'C' and entryid <> 'TR') or (catran.drcr = 'D' and entryid = 'TR'))   and catran.rlsed =  1     and entryid <> 'ZZ'
Order by Module, RefNbr, BatNbr, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CATran_Acct_Sub_DepSelect] TO [MSDSL]
    AS [dbo];


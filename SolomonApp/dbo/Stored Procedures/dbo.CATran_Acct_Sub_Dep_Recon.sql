 /****** Object:  Stored Procedure dbo.CATran_Acct_Sub_Dep_Recon   Script Date: 4/7/98 12:49:20 PM ******/
Create Proc CATran_Acct_Sub_Dep_Recon @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 smalldatetime, @parm5 smalldatetime, @parm6 smalldatetime, @parm7 varchar(1), @parm8 smallint as
Select * from CATran
Where bankcpnyid like @parm1
and BankAcct like @parm2
and Banksub like @parm3
AND ((@parm7 = 'O' and (RcnclStatus = 'O' or ClearDate > @parm6) and TranDate between (select paststartdate from casetup) and @parm4)
  OR ((@parm7 = 'C' and RcnclStatus = 'C') and (ClearDate > @parm5 and (ClearDate <=  @parm6 or @parm8=1 and TranDate<=@parm4)) and trandate >= (select paststartdate from casetup))
  OR (@parm7 = 'B' and ((RcnclStatus = 'O' and TranDate between (select paststartdate from casetup) and @parm4)
                    or (RcnclStatus = 'C' and (ClearDate > @parm5 and (ClearDate <=  @parm6 or TranDate<=@parm4)) and trandate >= (select paststartdate from casetup))
                       )
      )
     )
and ((catran.drcr = 'C' and (entryid <> 'TR' and entryid <> 'ZZ'))
or (catran.drcr = 'D' and entryid = 'TR')
or (catran.drcr = 'D' and entryid = 'ZZ' and RTRIM(catran.RefNbr) <> 'OFFSET'))
and catran.rlsed = 1
Order by BatNbr, RefNbr, trandate, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CATran_Acct_Sub_Dep_Recon] TO [MSDSL]
    AS [dbo];


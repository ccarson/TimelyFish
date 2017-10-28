 Create Proc  PRTran_BatNbr_AcctDist_AcctSub @parm1 varchar ( 10), @parm2 smallint as
       Select * from PRTran
           where BatNbr    =  @parm1
             and AcctDist  =  @parm2
             and TranAmt <> 0
           order by BatNbr,
                    Acct  ,
                    Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_BatNbr_AcctDist_AcctSub] TO [MSDSL]
    AS [dbo];


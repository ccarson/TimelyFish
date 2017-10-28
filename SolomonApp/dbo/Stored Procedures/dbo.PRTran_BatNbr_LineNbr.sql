 Create Proc  PRTran_BatNbr_LineNbr @parm1 varchar ( 10), @parm2beg smallint, @parm2end smallint as
       Select * from PRTran
           where BatNbr   =        @parm1
             and LineNbr  BETWEEN  @parm2beg and @parm2end
           order by BatNbr  ,
                    ChkAcct ,
                    ChkSub  ,
                    RefNbr  ,
                    TranType,
                    LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_BatNbr_LineNbr] TO [MSDSL]
    AS [dbo];


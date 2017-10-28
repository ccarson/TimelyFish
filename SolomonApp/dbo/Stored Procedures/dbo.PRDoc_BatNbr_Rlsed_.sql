 Create Proc  PRDoc_BatNbr_Rlsed_ @parm1 varchar ( 10), @parm2 smallint as
       Select * from PRDoc
           where BatNbr  =  @parm1
             and Rlsed   =  @parm2
           order by BatNbr ,
                    Acct   ,
                    Sub    ,
                    ChkNbr ,
                    DocType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDoc_BatNbr_Rlsed_] TO [MSDSL]
    AS [dbo];


 Create Proc PRDoc_Acct_Sub_ChkNbr @parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 varchar ( 10) as
       Select * from PRDoc
           where Acct    =  @parm1
             and Sub     =  @parm2
             and ChkNbr  =  @parm3
           order by Acct  ,
                    Sub   ,
                    ChkNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDoc_Acct_Sub_ChkNbr] TO [MSDSL]
    AS [dbo];


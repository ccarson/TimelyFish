 Create Proc  PRTran_DEL_BatNbr @parm1 varchar ( 10) as
       Delete prtran from PRTran
           where PRTran.BatNbr  =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_DEL_BatNbr] TO [MSDSL]
    AS [dbo];


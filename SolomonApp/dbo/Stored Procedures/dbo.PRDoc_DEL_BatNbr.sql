 Create Proc  PRDoc_DEL_BatNbr @parm1 varchar ( 10) as
       Delete prdoc from PRDoc
           where BatNbr  =  @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDoc_DEL_BatNbr] TO [MSDSL]
    AS [dbo];


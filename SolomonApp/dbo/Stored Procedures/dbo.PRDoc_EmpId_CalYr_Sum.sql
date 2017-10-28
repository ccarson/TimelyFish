 Create Proc  PRDoc_EmpId_CalYr_Sum @parm1 varchar ( 10), @parm2 varchar ( 4) as
       Select sum(NetAmt) from PRDoc
           where EmpId  =  @parm1
             and CalYr  =  @parm2
             and DocType  IN  ('HC', 'CK', 'ZC')



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDoc_EmpId_CalYr_Sum] TO [MSDSL]
    AS [dbo];


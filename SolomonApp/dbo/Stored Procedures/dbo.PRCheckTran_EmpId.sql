 Create Proc  PRCheckTran_EmpId @parm1 varchar ( 10) as
       Select * from PRCheckTran
           where EmpId  =  @parm1
           order by EmpId,
                    LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRCheckTran_EmpId] TO [MSDSL]
    AS [dbo];


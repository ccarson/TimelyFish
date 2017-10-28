 Create Proc  PRCheckTran_DEL_EmpId @parm1 varchar ( 10) as
       Delete prchecktran from PRCheckTran
           where EmpId  =  @parm1
		and ASID = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRCheckTran_DEL_EmpId] TO [MSDSL]
    AS [dbo];


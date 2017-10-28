 Create Proc  BenEmp_DEL_EmpId_Status @parm1 varchar ( 10), @parm2 varchar ( 2) as
       Delete benemp from BenEmp
           where EmpId   =  @parm1
             and Status  =  @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BenEmp_DEL_EmpId_Status] TO [MSDSL]
    AS [dbo];


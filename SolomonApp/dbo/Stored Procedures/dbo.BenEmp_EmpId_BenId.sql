 Create Proc  BenEmp_EmpId_BenId @parm1 varchar ( 10), @parm2 varchar ( 10) as
       Select * from BenEmp
           where EmpId  =     @parm1
             and BenId  LIKE  @parm2
           order by EmpId,
                    BenId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BenEmp_EmpId_BenId] TO [MSDSL]
    AS [dbo];


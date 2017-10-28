 Create Proc  BenEmp_TrnsBenId @parm1 varchar ( 10) as
       Select * from BenEmp
           where TrnsBenId  =  @parm1
           order by EmpId,
                    BenId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BenEmp_TrnsBenId] TO [MSDSL]
    AS [dbo];


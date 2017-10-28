 Create Proc  BenEmp_BenId @parm1 varchar ( 10) as
       Select * from BenEmp
           where BenId  =  @parm1
           order by EmpId



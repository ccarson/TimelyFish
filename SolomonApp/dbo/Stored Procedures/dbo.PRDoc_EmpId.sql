 Create Proc  PRDoc_EmpId @parm1 varchar ( 10) as
       Select * from PRDoc
           where EmpId  =  @parm1
           order by EmpId



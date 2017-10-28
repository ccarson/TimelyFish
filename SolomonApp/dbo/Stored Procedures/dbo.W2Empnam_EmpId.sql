 Create Proc W2Empnam_EmpId @parm1 varchar(10) as
       Select * from W2Empname
           where EmpId like @parm1
           order by EmpId



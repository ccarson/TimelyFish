 Create Proc  Employee_PayGrpId_CpnyId @parm1 varchar ( 6), @parm2 varchar (10) as
       Select * from Employee
           where PayGrpId LIKE @parm1
             and CpnyId   LIKE @parm2
           order by PayGrpId,
                    EmpId



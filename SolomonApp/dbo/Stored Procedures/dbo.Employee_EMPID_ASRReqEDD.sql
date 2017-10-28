 Create Proc  Employee_EMPID_ASRReqEDD @parm1 varchar ( 10) as
       Select Employee.* from Employee join vs_ASRReqEDD on Employee.empId = vs_ASRReqEDD.empId and vs_asrreqedd.doctype = 'D1'
           where employee.EmpId  LIKE  @parm1
           order by employee.EmpId


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Employee_EMPID_ASRReqEDD] TO [MSDSL]
    AS [dbo];


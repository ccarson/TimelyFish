
create procedure Employee_EmpId_w @parm1 varchar (10)  as
select DfltExpAcct, DfltExpSub, EmpID, PayType, Status, StdUnitRate, WCCode, dfltwrkloc, dfltearntype, HomeUnion  from EMPLOYEE
where EmpID = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Employee_EmpId_w] TO [MSDSL]
    AS [dbo];


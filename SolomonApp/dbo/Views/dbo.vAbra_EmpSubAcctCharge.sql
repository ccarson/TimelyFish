Create view vAbra_EmpSubAcctCharge
as 

Select ChargeDate,EmpType,e.EmpNo,
sum(jc.Amount) as SubAmount,FirstName, LastName,subacct, jc.CpnyID,TermDate
from vAbra_Employee_FullEmpNo e
LEFT JOIN vAbra_HrJobCst jc on e.EmpNo=jc.EmpNo

where subacct in (Select sub from subacct)
Group by e.EmpNo,EmpType,jc.subacct,jc.ChargeDate,jc.CpnyID,TermDate,FirstName, LastName


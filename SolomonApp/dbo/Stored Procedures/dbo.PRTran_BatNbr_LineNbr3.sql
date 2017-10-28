 Create Proc PRTran_BatNbr_LineNbr3 @parm1 varchar ( 10), @parm2 varchar(16), @parm3beg smallint, @parm3end smallint as
Select *
from PRTran
	left outer join Employee
		on PRTran.EmpId = Employee.EmpId
	left outer join EarnType
		on PRTran.EarnDedId = EarnType.Id
where PRTran.BatNbr = @parm1
	and PRTran.ProjectId like @parm2
	and PRTran.LineNbr BETWEEN @parm3beg and @parm3end
order by PRTran.LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRTran_BatNbr_LineNbr3] TO [MSDSL]
    AS [dbo];


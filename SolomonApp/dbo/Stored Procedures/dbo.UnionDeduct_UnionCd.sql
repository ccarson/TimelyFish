 Create Proc UnionDeduct_UnionCd @parm1 varchar (4), @parm2 varchar (10), @parm3 varchar (4), @parm4 varchar (10) as
Select *
from UnionDeduct
	left outer join Deduction
		on UnionDeduct.DedId = Deduction.DedId
where Deduction.CalYr = @parm1
	and UnionDeduct.Union_Cd = @parm2
	and UnionDeduct.Labor_Class_Cd like @parm3
	and UnionDeduct.DedId like @parm4
Order by UnionDeduct.Labor_Class_Cd, UnionDeduct.DedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[UnionDeduct_UnionCd] TO [MSDSL]
    AS [dbo];


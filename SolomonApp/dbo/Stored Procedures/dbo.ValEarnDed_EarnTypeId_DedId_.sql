 Create Proc ValEarnDed_EarnTypeId_DedId_ @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 4) as
Select *
from ValEarnDed
	left outer join Deduction
		on ValEarnDed.DedId = Deduction.DedId
where ValEarnDed.EarnTypeId = @parm1
	and ValEarnDed.DedId LIKE @parm2
	and Deduction.CalYr = @parm3
order by ValEarnDed.EarnTypeId, ValEarnDed.DedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ValEarnDed_EarnTypeId_DedId_] TO [MSDSL]
    AS [dbo];


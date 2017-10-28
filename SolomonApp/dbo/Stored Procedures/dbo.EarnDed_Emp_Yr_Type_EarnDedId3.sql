 Create Proc  EarnDed_Emp_Yr_Type_EarnDedId3 @parm1 varchar ( 10), @parm2 varchar ( 4), @parm3 varchar ( 1), @parm4 varchar ( 10) as
       Select *
		   from EarnDed
				left outer join Deduction
					on EarnDed.EarnDedId = Deduction.DedId
           where EmpId      =     @parm1
             and EarnDed.CalYr =  @parm2
             and EDType       =     @parm3
             and EarnDedId  LIKE  @parm4
             and Deduction.CalYr = @parm2
           order by EarnDedId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnDed_Emp_Yr_Type_EarnDedId3] TO [MSDSL]
    AS [dbo];


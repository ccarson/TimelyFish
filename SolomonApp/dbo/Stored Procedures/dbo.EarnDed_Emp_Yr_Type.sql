 Create Proc  EarnDed_Emp_Yr_Type @parm1 varchar ( 10), @parm2 varchar ( 4), @parm3 varchar ( 1) as
       Select * from EarnDed
           where EmpId      =     @parm1
             and EarnDed.CalYr =  @parm2
             and EDType       =     @parm3
	    
           order by EarnDedType, EarnDedId


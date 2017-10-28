 Create Proc  EarnDed_EmpId_DedId_Sum @parm1 varchar ( 10), @parm2 varchar ( 10) as
       Select SUM(CalYTDEarnDed) from EarnDed
           Where EmpId      =     @parm1
             and EDType     =     "D"
             and EarnDedId  =     @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EarnDed_EmpId_DedId_Sum] TO [MSDSL]
    AS [dbo];


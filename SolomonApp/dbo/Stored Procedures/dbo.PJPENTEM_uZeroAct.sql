 create procedure PJPENTEM_uZeroAct @parm1 varchar (16)  as
Update PJPENTEM set
Actual_amt = 0,
ProjCury_Actual_amt = 0,
Actual_units = 0,
Revadj_Amt = 0,
ProjCury_Revadj_Amt = 0,
Revenue_Amt = 0,
ProjCury_Revenue_amt = 0
WHERE project like @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEM_uZeroAct] TO [MSDSL]
    AS [dbo];


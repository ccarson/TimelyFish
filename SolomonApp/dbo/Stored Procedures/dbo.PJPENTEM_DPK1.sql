 create procedure PJPENTEM_DPK1  @parm1 varchar (16) as
    delete from PJPENTEM
        where Project = @parm1
		and Actual_amt = 0
		and Actual_units = 0
		and Revadj_amt = 0
		and Revenue_amt = 0

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEM_DPK1] TO [MSDSL]
    AS [dbo];


 create procedure PJPENTEM_SPK5 @parm1 varchar (16), @parm2 varchar (10)  as
select * from PJPENTEM
where project like @parm1
and employee = @parm2
and ( budget_amt <> 0 or budget_units <> 0 )


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEM_SPK5] TO [MSDSL]
    AS [dbo];


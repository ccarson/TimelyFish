create procedure PJPENTEM_SCount @parm1 varchar (16) as
select count(*) from PJPENTEM
where project like @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEM_SCount] TO [MSDSL]
    AS [dbo];


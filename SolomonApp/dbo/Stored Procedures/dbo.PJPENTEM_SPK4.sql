 create procedure PJPENTEM_SPK4 @parm1 varchar (16), @parm2 varchar (32),  @parm3 varchar (10), @parm4 varchar (50)  as
select * from PJPENTEM
where project like @parm1
and pjt_entity  like  @parm2
and employee = @parm3
and SubTask_Name like @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEM_SPK4] TO [MSDSL]
    AS [dbo];


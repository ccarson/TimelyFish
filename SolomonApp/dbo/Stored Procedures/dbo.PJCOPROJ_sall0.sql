 create procedure PJCOPROJ_sall0 @parm1 varchar (16) , @parm2 varchar (16)  as
select * from PJCOPROJ
where project  =    @parm1 and
owner_co like @parm2 and
owner_co <>   ''
order by
project,
owner_co



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOPROJ_sall0] TO [MSDSL]
    AS [dbo];


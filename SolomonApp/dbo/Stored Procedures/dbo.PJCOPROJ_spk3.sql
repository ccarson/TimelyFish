 create procedure PJCOPROJ_spk3 @parm1 varchar (16)  as
select * from PJCOPROJ
where project  =    @parm1
order by
project,
owner_co



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOPROJ_spk3] TO [MSDSL]
    AS [dbo];


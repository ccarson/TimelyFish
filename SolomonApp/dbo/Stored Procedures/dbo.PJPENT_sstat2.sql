 create procedure PJPENT_sstat2 @parm1 varchar (16) , @parm2 varchar (1) , @parm3 varchar (1)   as
select * from PJPENT
where project =  @parm1 and
(status_pa = @parm2 or
status_pa = @parm3)
order by project, pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENT_sstat2] TO [MSDSL]
    AS [dbo];


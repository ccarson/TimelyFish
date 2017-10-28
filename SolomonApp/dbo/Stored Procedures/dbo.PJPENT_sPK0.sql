 create procedure PJPENT_sPK0 @parm1 varchar (16) , @PARM2 varchar (32)   as
select * from PJPENT
where project =  @parm1 and
pjt_entity =  @parm2
order by project, pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENT_sPK0] TO [MSDSL]
    AS [dbo];


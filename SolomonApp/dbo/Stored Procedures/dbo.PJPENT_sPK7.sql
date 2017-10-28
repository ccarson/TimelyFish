 create procedure PJPENT_sPK7 @parm1 varchar (16) , @PARM2 varchar (32)   as
select * from PJPENT
where project =  @parm1 and
pjt_entity Like  @parm2 and
status_pa = 'A' and
status_lb = 'A'
order by project, pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENT_sPK7] TO [MSDSL]
    AS [dbo];


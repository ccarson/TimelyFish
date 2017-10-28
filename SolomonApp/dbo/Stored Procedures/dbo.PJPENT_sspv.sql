 create procedure PJPENT_sspv @parm1 varchar (16) , @parm2 varchar (32)   as
select * from PJPENT
where project like  @parm1 and pjt_entity  like  @parm2
order by project, pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENT_sspv] TO [MSDSL]
    AS [dbo];


 create procedure PJPENT_sALL @parm1 varchar (16) , @parm2 varchar (32)   as
select * from PJPENT
where project =  @parm1 and pjt_entity  like  @parm2
order by project, pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENT_sALL] TO [MSDSL]
    AS [dbo];


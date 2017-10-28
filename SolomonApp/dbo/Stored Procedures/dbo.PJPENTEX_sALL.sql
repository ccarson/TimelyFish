 create procedure PJPENTEX_sALL @parm1 varchar (16) , @parm2 varchar (32)   as
select * from PJPENTEX
where project =  @parm1
	  and pjt_entity  like  @parm2
order by project, pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEX_sALL] TO [MSDSL]
    AS [dbo];


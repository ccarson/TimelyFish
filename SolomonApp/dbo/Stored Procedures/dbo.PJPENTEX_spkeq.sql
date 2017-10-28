 create procedure PJPENTEX_spkeq @parm1 varchar (16) , @parm2 varchar (32)   as
select * from PJPENTEX
where project =  @parm1
	  and pjt_entity  =  @parm2
order by project, pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEX_spkeq] TO [MSDSL]
    AS [dbo];


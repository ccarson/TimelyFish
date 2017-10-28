 create procedure PJPROJMX_SALL  @parm1 varchar (16), @parm2 varchar (32), @parm3 varchar (16) as
select  * from PJPROJMX
where    project     =  @parm1 and
         pjt_entity  =  @parm2 and
	   acct	   like @parm3
order by project, pjt_entity, acct


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJMX_SALL] TO [MSDSL]
    AS [dbo];


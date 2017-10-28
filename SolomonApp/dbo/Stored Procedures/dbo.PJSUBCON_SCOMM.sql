 create procedure PJSUBCON_SCOMM  @parm1 varchar (16) , @parm2 varchar (16)   as
select * from PJSUBCON
where    project = @parm1 and
subcontract like @parm2 and
	     status_sub = 'A'
order by project, subcontract



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBCON_SCOMM] TO [MSDSL]
    AS [dbo];


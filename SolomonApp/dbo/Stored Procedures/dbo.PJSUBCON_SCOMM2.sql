 create procedure PJSUBCON_SCOMM2  @parm1 varchar (16) , @parm2 varchar (16)   as
select * from PJSUBCON
where    project like @parm1 and
subcontract like @parm2 and
status_sub = 'A'
order by project, subcontract



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBCON_SCOMM2] TO [MSDSL]
    AS [dbo];


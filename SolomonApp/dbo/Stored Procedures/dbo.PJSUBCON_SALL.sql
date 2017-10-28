 create procedure PJSUBCON_SALL  @parm1 varchar (16) , @parm2 varchar (16)   as
select * from PJSUBCON
where    project = @parm1 and
subcontract like @parm2
order by project, subcontract



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBCON_SALL] TO [MSDSL]
    AS [dbo];


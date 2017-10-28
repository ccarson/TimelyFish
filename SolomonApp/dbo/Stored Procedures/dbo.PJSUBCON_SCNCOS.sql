 create procedure PJSUBCON_SCNCOS  @parm1 varchar (16) , @parm2 varchar (16)   as
select * from PJSUBCON
where    project     =    @parm1 and
subcontract like @parm2 and
status_sub  <>   ''
order by project, subcontract



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBCON_SCNCOS] TO [MSDSL]
    AS [dbo];


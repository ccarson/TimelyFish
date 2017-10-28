 create procedure PJSUBCON_SPK0  @parm1 varchar (16) , @parm2 varchar (16)   as
select * from PJSUBCON
where    project     LIKE @parm1 and
subcontract LIKE @parm2
order by project, subcontract



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBCON_SPK0] TO [MSDSL]
    AS [dbo];


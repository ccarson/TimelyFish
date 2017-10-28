 create procedure PJSUBCON_SPK1  @parm1 varchar (16) , @parm2 varchar (16)   as
select * from PJSUBCON
where    project     =     @parm1 and
subcontract =     @parm2
order by project, subcontract



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBCON_SPK1] TO [MSDSL]
    AS [dbo];


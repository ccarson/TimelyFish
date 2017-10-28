 create procedure PJPTDSUM_spk1 @parm1 varchar (16) , @parm2 varchar (32) , @parm3 varchar (16)    as
select * from PJPTDSUM
where project =  @parm1 and
pjt_entity = @parm2 and
acct like @parm3
order by project, pjt_entity, acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_spk1] TO [MSDSL]
    AS [dbo];


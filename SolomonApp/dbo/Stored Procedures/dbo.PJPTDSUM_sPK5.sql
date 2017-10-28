 create procedure PJPTDSUM_sPK5 @parm1 varchar (16) , @parm2 varchar (32) , @parm3 varchar (16)   as
select * from PJPTDSUM
where project =  @parm1 and
pjt_entity  =  @parm2 and
acct = @parm3
order by project, pjt_entity, acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPTDSUM_sPK5] TO [MSDSL]
    AS [dbo];


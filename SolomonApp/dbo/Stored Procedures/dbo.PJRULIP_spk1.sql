 create procedure PJRULIP_spk1 @parm1 varchar (4) ,@parm2 varchar (16)   as
select * from PJRULIP
where bill_type_cd =  @parm1 and
PJRULIP.acct =  @parm2
order by bill_type_cd, acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRULIP_spk1] TO [MSDSL]
    AS [dbo];


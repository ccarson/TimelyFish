 create procedure PJRULES_spk1 @parm1 varchar (4) , @parm2 varchar (16) , @parm3 varchar (1)   as
select * from PJRULES
where bill_type_cd = @parm1 and
acct         = @parm2 and
li_type      = @parm3
order by bill_type_cd, acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJRULES_spk1] TO [MSDSL]
    AS [dbo];


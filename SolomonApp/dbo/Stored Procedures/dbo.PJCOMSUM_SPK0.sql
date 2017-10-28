 create procedure PJCOMSUM_SPK0 @parm1 varchar (4) , @parm2 varchar (16) , @parm3 varchar (32) , @parm4 varchar (16)  as
select * from PJCOMSUM
where    fsyear_num = @parm1
and    project    = @parm2
and    pjt_entity = @parm3
and    acct       = @parm4
order by fsyear_num,
project,
pjt_entity,
acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMSUM_SPK0] TO [MSDSL]
    AS [dbo];


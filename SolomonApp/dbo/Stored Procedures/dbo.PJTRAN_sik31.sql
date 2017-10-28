 create procedure PJTRAN_sik31 @parm1 varchar (6) , @parm2 varchar (16) , @parm3 varchar (16) , @parm4 varchar (16) , @parm5 varchar (16)   as
select * from PJTRAN
where
fiscalno = @parm1 and
project  = @parm2  and
(acct     = @parm3 or
acct     = @parm4 or
acct     = @parm5) and
tr_status = ' '
order by  FISCALNO,
PROJECT,
PJT_ENTITY,
ACCT,
TRANS_DATE



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTRAN_sik31] TO [MSDSL]
    AS [dbo];


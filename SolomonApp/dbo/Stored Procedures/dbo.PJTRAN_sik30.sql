 create procedure PJTRAN_sik30 @parm1 varchar (6) , @parm2 varchar (16) , @parm3 varchar (16)   as
select * from PJTRAN
where
fiscalno = @parm1 and
project = @parm2  and
acct    = @parm3 and
tr_status = ' '
order by  FISCALNO,
PROJECT,
PJT_ENTITY,
ACCT,
TRANS_DATE



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTRAN_sik30] TO [MSDSL]
    AS [dbo];


 create procedure PJCHARGH_SI01 @parm1 varchar (6)   as
select Count(*) from PJCHARGH
where   FiscalNo = @parm1 and
Batch_Status <> 'P'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCHARGH_SI01] TO [MSDSL]
    AS [dbo];


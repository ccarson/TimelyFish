 create procedure PJCOMSUM_delete @parm1 varchar (04) as
Delete from PJCOMSUM
WHERE
fsyear_num <= @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMSUM_delete] TO [MSDSL]
    AS [dbo];


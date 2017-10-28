 create procedure PJBUDSUM_delete @parm1 varchar (04) as
Delete from PJBUDSUM
WHERE
fsyear_num <= @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBUDSUM_delete] TO [MSDSL]
    AS [dbo];


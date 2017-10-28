 create procedure PJACTSUM_delete @parm1 varchar (04) as
Delete from PJACTSUM
WHERE
fsyear_num <= @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJACTSUM_delete] TO [MSDSL]
    AS [dbo];


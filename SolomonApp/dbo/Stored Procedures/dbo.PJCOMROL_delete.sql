 create procedure PJCOMROL_delete @parm1 varchar (04) as
Delete from PJCOMROL
WHERE
fsyear_num <= @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMROL_delete] TO [MSDSL]
    AS [dbo];


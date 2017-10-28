 create procedure PJACTROL_delete @parm1 varchar (04) as
Delete from PJACTROL
WHERE
fsyear_num <= @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJACTROL_delete] TO [MSDSL]
    AS [dbo];


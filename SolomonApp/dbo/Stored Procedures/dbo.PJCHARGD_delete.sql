 create procedure PJCHARGD_delete @parm1 varchar (10) as
Delete from PJCHARGD
WHERE
batch_id = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCHARGD_delete] TO [MSDSL]
    AS [dbo];


 create procedure PJLABDET_delete @parm1 varchar (10) as
Delete from PJLABDET
WHERE
docnbr = @parm1
Delete from PJLABDLY
WHERE
docnbr = @parm1
Delete from PJLABAUD
WHERE
docnbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDET_delete] TO [MSDSL]
    AS [dbo];


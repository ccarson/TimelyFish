 create procedure PJTIMDET_delete @parm1 varchar (10) as
Delete from PJTIMDET
WHERE
docnbr = @parm1
Delete from PJUOPDET
WHERE
docnbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTIMDET_delete] TO [MSDSL]
    AS [dbo];


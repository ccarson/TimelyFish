 create procedure PJEXPDET_delete @parm1 varchar (10) as
Delete from PJEXPDET
WHERE
docnbr = @parm1
Delete from PJEXPAUD
WHERE
docnbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEXPDET_delete] TO [MSDSL]
    AS [dbo];


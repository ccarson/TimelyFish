 create procedure PJTIMDET_init
as
SELECT * from PJTIMDET
WHERE
docnbr = 'Z'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTIMDET_init] TO [MSDSL]
    AS [dbo];


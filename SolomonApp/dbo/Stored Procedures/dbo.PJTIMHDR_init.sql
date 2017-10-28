 create procedure PJTIMHDR_init
as
SELECT * from PJTIMHDR
WHERE
docnbr = 'Z'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTIMHDR_init] TO [MSDSL]
    AS [dbo];


 create procedure GLTRAN_Init
as
select * from GLTRAN
where Module = 'Z'
and BatNbr = 'Z'
and LineNbr = 9



GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTRAN_Init] TO [MSDSL]
    AS [dbo];


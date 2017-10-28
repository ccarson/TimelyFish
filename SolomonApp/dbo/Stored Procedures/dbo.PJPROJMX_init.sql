 create procedure PJPROJMX_init
as
select * from PJPROJMX  where
project     =  'Z' and
pjt_entity    = 'Z' and
acct = 'Z'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJMX_init] TO [MSDSL]
    AS [dbo];


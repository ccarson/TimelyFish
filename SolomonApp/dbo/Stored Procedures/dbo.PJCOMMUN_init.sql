 create procedure PJCOMMUN_init
as
SELECT * from PJCOMMUN
WHERE
msg_type = 'Z' and
msg_key = 'Z' and
msg_suffix = 'Z'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMMUN_init] TO [MSDSL]
    AS [dbo];


 create procedure PJCOMMUN_spk1 @parm1 varchar (6) , @parm2 varchar (48) , @parm3 varchar (2)   as
SELECT * from PJCOMMUN
WHERE
        msg_type = @parm1 and
msg_key = @parm2 and
msg_suffix = @parm3
ORDER BY
destination,
msg_status,
PJCOMMUN.crtd_datetime



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMMUN_spk1] TO [MSDSL]
    AS [dbo];


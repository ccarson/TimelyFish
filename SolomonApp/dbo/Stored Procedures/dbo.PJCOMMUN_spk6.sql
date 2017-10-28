 create procedure PJCOMMUN_spk6 @parm1 varchar (1)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
select * from pjcommun, vs_UserRec
where destination = vs_UserRec.USERID and
destination_type = 'U' and
PJCOMMUN.msg_status = @parm1 and
(mail_flag = 1 or mail_flag = 2)
order by PJCOMMUN.destination,
PJCOMMUN.msg_status,
PJCOMMUN.crtd_datetime



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMMUN_spk6] TO [MSDSL]
    AS [dbo];


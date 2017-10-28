 create procedure PJCOMMUN_spk2 @parm1 varchar (10)   as
select * from PJCOMMUN
where    sender  = @parm1
order by destination,
msg_status,
PJCOMMUN.crtd_datetime



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMMUN_spk2] TO [MSDSL]
    AS [dbo];


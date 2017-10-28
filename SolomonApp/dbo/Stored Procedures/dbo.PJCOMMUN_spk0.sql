 create procedure PJCOMMUN_spk0 @parm1 varchar (10)   as
select * from PJCOMMUN
where    destination    =    @parm1
order by destination,
msg_status,
PJCOMMUN.crtd_datetime



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMMUN_spk0] TO [MSDSL]
    AS [dbo];


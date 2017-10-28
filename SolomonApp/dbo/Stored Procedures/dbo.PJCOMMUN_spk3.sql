 create procedure PJCOMMUN_spk3 @parm1 varchar (10)   as
select *
	from PJCOMMUN
		left outer join PJEMPLOY
			on PJCOMMUN.sender = PJEMPLOY.employee
	where PJCOMMUN.destination  = @parm1
	order by PJCOMMUN.destination,
		PJCOMMUN.msg_status,
		PJCOMMUN.crtd_datetime



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMMUN_spk3] TO [MSDSL]
    AS [dbo];


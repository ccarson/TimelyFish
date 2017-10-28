 create procedure PJCOMMUN_spk5 @parm1 varchar (1)   as
select * from PJCOMMUN, PJEMPLOY
where    PJCOMMUN.destination    = PJEMPLOY.employee
and    PJCOMMUN.msg_status     = @parm1
and    PJEMPLOY.em_id03        = ''
and   (PJEMPLOY.em_id06 = 1 OR PJEMPLOY.em_id06 = 2)
order by PJCOMMUN.destination,
PJCOMMUN.msg_status,
PJCOMMUN.crtd_datetime



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMMUN_spk5] TO [MSDSL]
    AS [dbo];


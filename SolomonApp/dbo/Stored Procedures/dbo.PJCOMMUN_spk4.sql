 create procedure PJCOMMUN_spk4 @parm1 varchar (1)   as
select PJCOMMUN.*, RECEIPT.*, SENDER.*
	from PJCOMMUN
		left outer join  PJEMPLOY SENDER
			on PJCOMMUN.sender = SENDER.employee
		, PJEMPLOY RECEIPT
	where PJCOMMUN.destination = RECEIPT.employee
		and PJCOMMUN.msg_status = @parm1
		and RECEIPT.em_id03 <> ''
		and (RECEIPT.em_id06 = 1 OR RECEIPT.em_id06 = 2)
	order by PJCOMMUN.destination,
		PJCOMMUN.msg_status,
		PJCOMMUN.crtd_datetime



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMMUN_spk4] TO [MSDSL]
    AS [dbo];


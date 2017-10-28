create Proc RCCue_COMMESS @parm1 varchar(10) as
select count(*) from PJCOMMUN, PJEMPLOY  
where  PJEMPLOY.user_id = @parm1 and (PJCOMMUN.destination = PJEMPLOY.employee or PJCOMMUN.destination = @parm1) 
and PJCOMMUN.msg_status = 'N'

GO
GRANT CONTROL
    ON OBJECT::[dbo].[RCCue_COMMESS] TO [MSDSL]
    AS [dbo];


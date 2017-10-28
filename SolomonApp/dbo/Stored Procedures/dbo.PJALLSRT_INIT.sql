 create procedure PJALLSRT_INIT as
select * from PJALLSRT
where src_project = ' '
and allsrt_key    = 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLSRT_INIT] TO [MSDSL]
    AS [dbo];


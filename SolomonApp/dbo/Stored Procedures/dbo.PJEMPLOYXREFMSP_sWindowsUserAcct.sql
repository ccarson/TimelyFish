create procedure PJEMPLOYXREFMSP_sWindowsUserAcct @parm1 varchar (85)  as
select * from PJEMPLOYXREFMSP
where WindowsUserAcct    like @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJEMPLOYXREFMSP_sWindowsUserAcct] TO [MSDSL]
    AS [dbo];


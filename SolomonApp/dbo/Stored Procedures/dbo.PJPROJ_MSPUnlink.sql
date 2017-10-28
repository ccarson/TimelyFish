 create procedure PJPROJ_MSPUnlink @parm1 varchar (16)  as
update pjproj set
    MSPINTERFACE = ' ',
    mspproj_id = 0,
    status_18 = ' '
    where project = @parm1
update pjpent set
    MSPINTERFACE = ' ',
    msptask_uid = 0
    where project = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_MSPUnlink] TO [MSDSL]
    AS [dbo];


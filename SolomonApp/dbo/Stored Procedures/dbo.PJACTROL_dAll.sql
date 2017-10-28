 create procedure PJACTROL_dAll @parm1 varchar (16)  as
Delete from PJACTROL
WHERE
project like @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJACTROL_dAll] TO [MSDSL]
    AS [dbo];


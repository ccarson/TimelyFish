 create procedure PJACTSUM_dAll @parm1 varchar (16)  as
Delete from PJACTSUM
WHERE
project like @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJACTSUM_dAll] TO [MSDSL]
    AS [dbo];


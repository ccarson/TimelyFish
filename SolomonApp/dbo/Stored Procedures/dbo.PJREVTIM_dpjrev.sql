 create procedure PJREVTIM_dpjrev @parm1 varchar (16) , @parm2 varchar (4)  as
Delete    from PJREVTIM
WHERE      project = @parm1 and
revid = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJREVTIM_dpjrev] TO [MSDSL]
    AS [dbo];


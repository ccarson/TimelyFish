Create procedure [dbo].[PJREVTIM_dpjrevtacct] @parm1 varchar (16) , @parm2 varchar (4) , @parm3 varchar (32), @parm4 varchar(16) as
    Delete    from PJREVTIM
        WHERE      project = @parm1 and
                   revid = @parm2 and
                   pjt_entity = @parm3 and
                   acct = @parm4

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJREVTIM_dpjrevtacct] TO [MSDSL]
    AS [dbo];


 create procedure PJREVTIM_Spk0 @parm1 varchar (4) , @parm2 varchar (16) , @parm3 varchar (32) , @parm4 varchar (16) , @parm5 varchar (6)  as
SELECT  *    from PJREVTIM
WHERE      RevId = @parm1 and
Project = @parm2 and
Pjt_Entity = @parm3 and
Acct = @parm4 and
fiscalno Like @parm5
	ORDER BY  revid, project, pjt_entity, acct, fiscalno



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJREVTIM_Spk0] TO [MSDSL]
    AS [dbo];


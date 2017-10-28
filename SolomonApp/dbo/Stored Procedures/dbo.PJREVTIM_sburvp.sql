 create procedure PJREVTIM_sburvp @parm1 varchar (16) , @parm2 varchar (4) , @parm3 varchar (32) , @parm4 varchar (16) , @parm5 varchar (6)   as
SELECT  *    from PJREVTIM T, PJFISCAL F
WHERE     T.Project = @parm1 and
T.RevId = @parm2 and
T.Pjt_Entity = @parm3 and
T.Acct = @parm4 and
T.Fiscalno LIKE @parm5 and
T.FiscalNo = F.Fiscalno
	ORDER BY  T.Project, T.revid, T.pjt_entity, T.acct, T.fiscalno



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJREVTIM_sburvp] TO [MSDSL]
    AS [dbo];


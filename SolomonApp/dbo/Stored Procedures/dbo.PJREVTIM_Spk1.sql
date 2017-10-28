 create procedure PJREVTIM_Spk1 @parm1 varchar (4) , @parm2 varchar (16) , @parm3 varchar (32) , @parm4 varchar (16)  as
SELECT  *    from PJREVTIM
WHERE              RevId = @parm1 and
Project = @parm2 and
Pjt_Entity = @parm3 and
Acct = @parm4
ORDER BY  revid, project, pjt_entity, acct, fiscalno



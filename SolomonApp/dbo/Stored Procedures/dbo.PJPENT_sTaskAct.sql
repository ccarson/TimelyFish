 create procedure PJPENT_sTaskAct  @parm1 varchar (16) , @parm2 varchar (32)  as
SELECT   *
FROM     PJPENT
WHERE    project = @parm1 and
pjt_entity = @parm2 and
status_pa = 'A'
ORDER BY project, pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENT_sTaskAct] TO [MSDSL]
    AS [dbo];


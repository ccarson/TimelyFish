 create procedure PJREVCAT_sExport @parm1 varchar (16) , @parm2 varchar (4)   as
SELECT  * from PJREVCAT C, PJREVTSK T
WHERE
c.project =  @parm1 and
c.RevId =  @parm2 and
c.pjt_entity = t.pjt_entity and
c.RevId = t.RevId and
c.project = t.project
ORDER BY
c.project,
c.pjt_entity,
c.acct



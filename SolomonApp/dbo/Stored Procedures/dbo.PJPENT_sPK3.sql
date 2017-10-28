 create procedure PJPENT_sPK3 @parm1 varchar (16) , @PARM2 varchar (32)  as
SELECT * from PJPENT
WHERE    project =  @parm1 and
pjt_entity =  @parm2 and
status_pa = 'A' and
status_ap = 'A'
ORDER BY project, pjt_entity



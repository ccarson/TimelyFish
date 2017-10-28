 create procedure PJREVTSK_sBrowse @parm1 varchar (16) , @parm2 varchar (4) , @parm3 varchar (32)   as
SELECT  * FROM PJREVTSK
WHERE project = @parm1 and
pjt_entity IN
(Select pjt_entity from pjrevcat where project =  @parm1 and revid = @parm2) and
pjt_entity = @parm3
	ORDER BY  	project,
		pjt_entity



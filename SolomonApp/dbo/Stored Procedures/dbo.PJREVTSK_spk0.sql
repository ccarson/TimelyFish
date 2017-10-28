 create procedure PJREVTSK_spk0 @parm1 varchar (16) , @parm2 varchar (4) , @parm3 varchar (32)  as
SELECT  *    from PJREVTSK
WHERE       project = @parm1 and
	    revid = @parm2 and
pjt_entity = @parm3
ORDER BY        project, revid,  pjt_entity



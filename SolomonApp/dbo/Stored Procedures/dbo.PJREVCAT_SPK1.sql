 create procedure PJREVCAT_SPK1 @parm1 varchar (16) , @parm2 varchar (4)  as
SELECT  *    from PJREVCAT
WHERE       pjrevcat.project = @parm1 and
pjrevcat.revid = @parm2
ORDER BY        pjrevcat.project,
pjrevcat.revid,
pjrevcat.pjt_entity,
pjrevcat.acct


